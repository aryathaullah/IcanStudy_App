import SwiftUI

struct WelcomeView2: View {
    
    @State var isAnimating = false

    var body: some View {
        
        
     
        NavigationStack{
            
            ZStack {
                
                // background app ( sea )
                Image("background_app")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
              
                // welcome fish components
                VStack {
                    Image("welcome_fish_2")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.8)
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                        .offset(x:-15, y:-30)
                        .rotationEffect(.degrees(isAnimating ? 21 : 0))
                        .animation(
                            .bouncy(duration: 0.5)
                            .repeatForever(autoreverses: true),
                            value: isAnimating
                        )
                    
                    
                    // Tap to continue (ganti navigation linknya)
                   
                    NavigationLink(destination: WelcomeView2()) {
                        ZStack {
                          
                            Text("Tap to continue")
                                .font(Font.custom("Slackey-Regular", size: 17))
                                .opacity(0.8)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                                .offset(y: -80)


                        }
                    }
                   
                }
                
                //BUBBLE TEXT 2
                                  Image("bubble_text_2")
                                      .resizable()
                                      .scaledToFit()
                                      .scaleEffect(0.6)
                                      .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                                      .offset(x:90, y:-170)
                
                // Seaweed
                Image("seaweed")
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    .offset(x:0,y:230)
                    .scaleEffect(1.3)
                
                
            }.onAppear {
                isAnimating = true
            }
        }
    }
}

#Preview {
    WelcomeView2()
}
