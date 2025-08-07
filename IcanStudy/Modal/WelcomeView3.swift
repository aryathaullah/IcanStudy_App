import SwiftUI
struct WelcomePageView: View {
    
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    @State private var goToHome = false
    
    var body: some View {
        

        NavigationStack{
            
            ZStack {
                
                // background app
                Image("background_app")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
            
                // coins indicators
                ZStack {
                    Image("coins_indicator")
                        .resizable()
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    
                    Text("0")
                        .padding(.leading, 35)
                }
                .frame(width: 129, height: 52)
                .padding(.top, -380)
                .padding(.leading, 230)
                
                
                // welcome fish animation
                FocusFishAnimationsView()
                    .offset(x:-35, y:185)
            
                Image("bubble_text_3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(0.85)
                    .offset(x:60, y:70)
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    .padding()
                
                
                
                // home components
                VStack {
                    
                    // home title
                    Text("Today's Study Time")
                        .font(Font.custom("Slackey-Regular", size: 25))
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                    
                    // user's study hours
                    Text("00 : 00 : 00")
                        .font(Font.custom("Slackey-Regular", size: 50))
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                    
                    
                    // focus button
                GlowButtonView()
                    
                }
                .offset(y: -125)
                
                // main buttons
                HStack {
                    
                    // shop
                        Image("shops_action_button")
                            .resizable()
                            .frame(width: 69.15, height: 86.92)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer().frame(width: 150)
                    
                    // streak
                        Image("streak_action_button")
                            .resizable()
                            .frame(width: 102.49, height: 88.91)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                            .offset(x:22)
                    
                    .buttonStyle(PlainButtonStyle())
                }
                .offset(y: 350)
                NavigationLink(destination: HomeView(),  isActive: $goToHome) {
                                   EmptyView()
                               }
            }
            .navigationBarBackButtonHidden(true)
            .contentShape(Rectangle()) // Full screen tap area
                        .onTapGesture {
                            hasLaunchedBefore = true
                            goToHome = true
                        }
        }
    }
}

#Preview {
    WelcomePageView()
}
