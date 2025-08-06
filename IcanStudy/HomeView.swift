import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query private var users: [User]

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
                        .padding(.leading, 35)
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
                    Text("00:00:00")
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
                    
                    // shops action button
                    Button(action: {
                        print("SHOP")
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
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: User.self)
}
