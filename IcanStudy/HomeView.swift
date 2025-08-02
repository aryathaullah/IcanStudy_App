//
//  CircleImage.swift
//  Landmarks
//
//  Created by Mac on 29/07/25.
//

import SwiftUI

struct FishFood: Identifiable {
    let id = UUID()
    var position: CGPoint
}

struct FishSwimView: View {
    // Posisi ikan
    @State private var positionX: CGFloat = 100
    @State private var positionY: CGFloat = UIScreen.main.bounds.height / 2
    @State private var movingRight: Bool = true
    @State private var movingUp: Bool = true

    // Makanan
    @State private var foods: [FishFood] = []

    // Ukuran layar
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    // Kecepatan
    let horizontalSpeed: CGFloat = 0.7
    let verticalSpeed: CGFloat = 0.2

    // Batas gerakan vertikal
    let verticalTopLimit: CGFloat = 150
    let verticalBottomLimit: CGFloat = UIScreen.main.bounds.height - 150

    // Timer animasi ikan
    @State private var timer: Timer?
    @State private var showShopPopup = false

    var body: some View {
        ZStack {
            // background app
            Image("background_app")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // coins indicator
            VStack {
                    HStack {
                        Image("coins_indicator")
                            .resizable()
                            .frame(width: 129, height: 52)
                            .padding(.top, 50)
                            .padding(.leading, 250)
                    }
                    Spacer()
            }
            
            VStack {
                // title home page
                Text("Today's Study Time")
                    .font(Font.custom("Slackey-Regular", size: 24))
                    .foregroundStyle(Color.white)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                
                // button action
                Button(action: {
                    print("Tombol gambar ditekan!")
                }) {
                    ZStack {
                        Image("button_confirmation")
                            .resizable()
                            .frame(width: 180, height: 52)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)

                        Text("START")
                            .font(Font.custom("Slackey-Regular", size: 33))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
            }
            
            HStack{
                Button(action: {
                    showShopPopup = true
                }) {
                    Image("shops_action_button")
                                .resizable()
                                .frame(width: 69.15, height: 86.92)
                                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                    .frame(width: 150)
                
                Button(action: {
                    print("STREAK")
                }) {
                    Image("streak_action_button")
                                .resizable()
                                .frame(width: 102.49, height: 88.91)
                                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .offset(y:350)

            // 🍽️ Makanan ikan yang jatuh
            ForEach(foods) { food in
                Circle()
                    .fill(Color.brown)
                    .frame(width: 10, height: 10)
                    .position(food.position)
                    .transition(.scale)
            }

            // 🐟 Ikan
            Image("FishSwim1") // Ganti dengan nama gambar kamu
                .resizable()
                .frame(width: 80, height: 80)
                .scaleEffect(x: movingRight ? -1 : 1, y: 1) // balik arah
                .position(x: positionX, y: positionY)
        }
        .contentShape(Rectangle()) // biar gesture bisa diterapkan ke seluruh layar
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
        if showShopPopup {
            ShopPopupView {
                showShopPopup = false
            }
            .transition(.scale)
            .zIndex(1)
        }
    }
    

    func startSwimming() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { _ in
            // Gerak horizontal
            let dx = movingRight ? horizontalSpeed : -horizontalSpeed
            var newX = positionX + dx
            if newX >= screenWidth - 30 {
                newX = screenWidth - 30
                movingRight = false
            } else if newX <= 30 {
                newX = 30
                movingRight = true
            }

            // Gerak vertikal naik-turun
            let dy = movingUp ? -verticalSpeed : verticalSpeed
            var newY = positionY + dy
            if newY <= verticalTopLimit {
                newY = verticalTopLimit
                movingUp = false
            } else if newY >= verticalBottomLimit {
                newY = verticalBottomLimit
                movingUp = true
            }

            // Update posisi ikan
            DispatchQueue.main.async {
                positionX = newX
                positionY = newY
            }
        }
    }

    func dropFishFood(at location: CGPoint) {
        let food = FishFood(position: location)
        foods.append(food)

        // Animasikan makanan jatuh ke bawah
        withAnimation(.linear(duration: 2.5)) {
            if let index = foods.firstIndex(where: { $0.id == food.id }) {
                foods[index].position.y = screenHeight + 20
            }
        }

        // Hapus makanan setelah selesai animasi
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
            foods.removeAll { $0.id == food.id }
        }
    }
}

struct FishSwimView_Previews: PreviewProvider {
    static var previews: some View {
        FishSwimView()
    }
}

#Preview {
    FishSwimView()
}
