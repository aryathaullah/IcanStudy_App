import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query private var users: [User]
    
    @State private var showShopModal = false
    @State private var showStreakModal = false
    
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
                FishAnimationView()
                
                // coins indicators
                ZStack {
                    Image("coins_indicator")
                        .resizable()
                    
                    Text("\(users.first?.coins ?? 0)")
                        .font(Font.custom("Slackey-Regular", size: 15))
                        .foregroundStyle(Color.black)
                        .padding(.leading, 40)
                }
                .frame(width: 129, height: 52)
                .padding(.top, -370)
                .padding(.leading, 250)


                
                // home components
                VStack {
                    
                    // home title
                    Text("Today's Study Time")
                        .font(Font.custom("Slackey-Regular", size: 24))
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                    
                    // user's study hours
                    Text(StudySessionManager.getTotalTimeToday(context: context))
                        .font(Font.custom("Slackey-Regular", size: 53))
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                    
                    
                    
                    NavigationLink(destination: TimersView()) {
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
                .offset(y: -125)
                
                // main action button
                HStack {
                    
                    
                    Button(action: {
                        showShopModal = true
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
                    }) {
                        Image("streak_action_button")
                            .resizable()
                            .frame(width: 102.49, height: 88.91)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .offset(y: 350)
                
                if showStreakModal {
                    StreakModalView(isPresented: $showStreakModal)
                }
                
                if showShopModal {
                    ShopmodalView(isPresented: $showShopModal)
                }
                
            }
        }

    }

}

#Preview {
    HomeView().modelContainer(for: [User.self, StudySession.self])
}
