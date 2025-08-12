import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query private var users: [User]
    
    @State private var showCoinModal = false
    @State private var showShopModal = false
    @State private var showStreakModal = false
    @State private var showSeashellAnimation = true
    
    @State var refreshFishes = false
    
    @State private var todayStudyHours = 0

        var formattedTodaySession: String {
            let hours = todayStudyHours / 3600
            let minutes = (todayStudyHours % 3600) / 60
            let seconds = todayStudyHours % 60
            return String(format: "%02d : %02d : %02d", hours, minutes, seconds)
        }
    
    var body: some View {
        
        NavigationStack{
            
            ZStack {
                
                // background app ( sea )
                Image("background_app")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // fish animations
                FishAnimationView(refreshFish: $refreshFishes)
                
                // coins indicators
                ZStack {
                    Button(action: {
                        AudioHelper.playSound(named: "bubble_sfx")
                        showCoinModal = true
                    }) {
                        Image("coins_indicator")
                            .resizable()
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    }
                    
                    Text("\(users.first?.coins ?? 0)")
                        .font(Font.custom("Slackey-Regular", size: 15))
                        .foregroundStyle(.coin)
                        .opacity(0.7)
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    
                        .padding(.leading, 40)
                }
                .frame(width: 129, height: 52)
                .padding(.top, -370)
                .padding(.leading, 250)
                
//                Button(action: {
//                    currentFishNames.removeAll()
//                    FishStorageManager.resetFishNames()
//                    print(FishStorageManager.getFishNames())
//                    //nanti ini bkl bekerja, sementra utk reset button
//                }) {
//                    Image("red_back_button")
//                        .resizable()
//                        .frame(width: 69, height: 69)
//                        .padding()
//                }
//                .position(x: 300, y: 170)
    
                // home components
                VStack {
                    
                    // home title
                    Text("Today's Study Time")
                        .font(Font.custom("Slackey-Regular", size: 25))
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    
                    
                    // user's study hours
                    Text(StudySessionManager.getTotalTimeToday(context: context))
                        .font(Font.custom("Slackey-Regular", size: 50))
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    
                    
                    
                    NavigationLink(destination: TimersView()) {
                        ZStack {
                            GlowButtonView()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .offset(y: -125)
                
                // main action button
                HStack {
                    
                    
                    Button(action: {
                        showShopModal = true
                        AudioHelper.playSound(named: "bubble_sfx")
                    }) {
                        Image("shops_action_button")
                            .resizable()
                            .frame(width: 69.15, height: 86.92)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer().frame(width: 150)
                    
                    // streak action button
                    Button(action: {
                        showStreakModal = true
                        AudioHelper.playSound(named: "bubble_sfx")
                    }) {
                        Image("streak_action_button")
                            .resizable()
                            .frame(width: 102.49, height: 88.91)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                            .offset(x:20)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .offset(y: 350)
                
                if showStreakModal {
                    StreakModalView(isPresented: $showStreakModal)
                }
                
                if showShopModal {
                    ShopmodalView(showShopModal: $showShopModal)

                }
                
                if showCoinModal {
                    ModalCoin(showCoinModal: $showCoinModal)
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .onChange(of: showShopModal) { oldValue, newValue in
                print("SHOW SHOP MODAL")
                refreshFishes.toggle()
            }
        }

    }

}

#Preview {
    HomeView().modelContainer(for: [User.self, StudySession.self])
}
