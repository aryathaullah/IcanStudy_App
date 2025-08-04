import SwiftUI

struct FishFood: Identifiable {
    let id = UUID()
    var position: CGPoint
}

struct FishAnimationView: View {
    @State private var positionX: CGFloat = 100
    @State private var positionY: CGFloat = UIScreen.main.bounds.height / 2
    @State private var movingRight: Bool = true
    @State private var movingUp: Bool = true
    @State private var foods: [FishFood] = []
    @State private var timer: Timer?

    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    let horizontalSpeed: CGFloat = 0.7
    let verticalSpeed: CGFloat = 0.2

    let verticalTopLimit: CGFloat = 150
    let verticalBottomLimit: CGFloat = UIScreen.main.bounds.height - 150

    var body: some View {
        ZStack {
            // Makanan ikan
            ForEach(foods) { food in
                Circle()
                    .fill(Color.brown)
                    .frame(width: 10, height: 10)
                    .position(food.position)
                    .transition(.scale)
            }

            // Ikan
            Image("fish_shops_1")
                .resizable()
                .frame(width: 80, height: 80)
                .scaleEffect(x: movingRight ? 1 : -1, y: 1)
                .position(x: positionX, y: positionY)
        }
        .contentShape(Rectangle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .onEnded { value in
                    let location = value.location
                    dropFishFood(at: location)
                }
        )
        .onAppear {
            startSwimming()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    func startSwimming() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { _ in
            let dx = movingRight ? horizontalSpeed : -horizontalSpeed
            var newX = positionX + dx
            if newX >= screenWidth - 30 {
                newX = screenWidth - 30
                movingRight = false
            } else if newX <= 30 {
                newX = 30
                movingRight = true
            }

            let dy = movingUp ? -verticalSpeed : verticalSpeed
            var newY = positionY + dy
            if newY <= verticalTopLimit {
                newY = verticalTopLimit
                movingUp = false
            } else if newY >= verticalBottomLimit {
                newY = verticalBottomLimit
                movingUp = true
            }

            DispatchQueue.main.async {
                positionX = newX
                positionY = newY
            }
        }
    }

    func dropFishFood(at location: CGPoint) {
        let food = FishFood(position: location)
        foods.append(food)

        withAnimation(.linear(duration: 2.5)) {
            if let index = foods.firstIndex(where: { $0.id == food.id }) {
                foods[index].position.y = screenHeight + 20
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
            foods.removeAll { $0.id == food.id }
        }
    }
}
