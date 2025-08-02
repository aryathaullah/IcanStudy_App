import SwiftUI

struct HomeView: View {
    @State private var showShopPopup = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background_app")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                FishAnimationView()

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
                    Text("Today's Study Time")
                        .font(Font.custom("Slackey-Regular", size: 24))
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)

                    Text("00:00:00")
                        .font(Font.custom("Slackey-Regular", size: 53))
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                    NavigationStack{
                        NavigationLink(destination: SlidersView()) {
                            ZStack {
                                Image("button_confirmation")
                                    .resizable()
                                    .frame(width: 180, height: 52)
                                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                                Text("FOCUS")
                                    .font(Font.custom("Slackey-Regular", size: 33))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    }
                    .offset(y: -125)
                    

                HStack {
                    Button(action: {
                        showShopPopup = true
                    }) {
                        Image("shops_action_button")
                            .resizable()
                            .frame(width: 69.15, height: 86.92)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    }
                    .buttonStyle(PlainButtonStyle())

                    Spacer().frame(width: 150)

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
                .offset(y: 350)

//                if showShopPopup {
//                    ShopPopupView {
//                        showShopPopup = false
//                    }
//                    .transition(.scale)
//                    .zIndex(1)
//                }
            }
        }
    }
}

#Preview {
    HomeView()
}
