import SwiftUI

struct Fish: Identifiable {
    let id = UUID()
    var position: CGPoint
    var movingRight: Bool
    var movingUp: Bool
    let imageName: String
    var wiggleOffset: CGFloat = 0
    var baseY: CGFloat
}

struct FishAnimationView: View {
    @State private var fishes: [Fish] = []
    @State private var timer: Timer?
    @State private var wigglePhase: CGFloat = 0
    @Binding var refreshFish: Bool
    @State var fishImages = FishStorageManager.getFishNames()
    
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let horizontalSpeed: CGFloat = 0.2
    let verticalSpeed: CGFloat = 0.3
    let verticalTopLimit: CGFloat = -100
    let verticalBottomLimit: CGFloat = UIScreen.main.bounds.height + 20

    var body: some View {
        ZStack {
            ForEach(fishes) { fish in
                Image(fish.imageName)
                    .resizable()
                    .frame(width: 60, height: 50)
                    .scaleEffect(x: fish.movingRight ? 1 : -1, y: 1)
                    .position(x: fish.position.x,
                              y: fish.position.y + sin(wigglePhase + CGFloat(fish.id.hashValue % 100) / 20) * 5) // efek goyang
            }
        }
        
        .onAppear {
            fishImages = FishStorageManager.getFishNames()
            createFishes()
            startSwimming()
        }
        .onChange(of: refreshFish, { oldValue, newValue in
            print("REFRESH FISH")

            fishImages = FishStorageManager.getFishNames()
            createFishes()
        })
        
        .onDisappear {
            timer?.invalidate()
        }
    }

    func createFishes() {
        fishes = (0..<fishImages.count).map { index in
            let x = CGFloat.random(in: 50...(screenWidth - 50))
            let y = CGFloat.random(in: verticalTopLimit...verticalBottomLimit)
            return Fish(
                position: CGPoint(x: x, y: y),
                movingRight: Bool.random(),
                movingUp: Bool.random(),
                imageName: fishImages[index % fishImages.count],
                baseY: y
            )
        }
    }

    func startSwimming() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { _ in
            wigglePhase += 0.1

            fishes = fishes.map { fish in
                var newFish = fish

                // Horizontal movement
                let dx = newFish.movingRight ? horizontalSpeed : -horizontalSpeed
                var newX = newFish.position.x + dx
                if newX >= screenWidth - 30 {
                    newX = screenWidth - 30
                    newFish.movingRight = false
                } else if newX <= 30 {
                    newX = 30
                    newFish.movingRight = true
                }

                // Vertical movement
                let dy = newFish.movingUp ? -verticalSpeed : verticalSpeed
                var newY = newFish.position.y + dy
                if newY <= verticalTopLimit {
                    newY = verticalTopLimit
                    newFish.movingUp = false
                } else if newY >= verticalBottomLimit {
                    newY = verticalBottomLimit
                    newFish.movingUp = true
                }

                newFish.position = CGPoint(x: newX, y: newY)
                return newFish
            }
        }
    }
}

#Preview {
    FishAnimationView(refreshFish: .constant(false))
}
