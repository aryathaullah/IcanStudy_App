import SwiftUI

struct WelcomeView: View {
    
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    @State private var isAnimating = false
    @State private var goToNext = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Image("background_app")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                // Content
                VStack {
                    Image("welcome_fish_1")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.8)
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                        .offset(x: -15, y: -30)
                        .rotationEffect(.degrees(isAnimating ? 21 : 0))
                        .animation(
                            .bouncy(duration: 0.5)
                            .repeatForever(autoreverses: true),
                            value: isAnimating
                        )

                    Text("Tap to continue")
                        .font(Font.custom("Slackey-Regular", size: 17))
                        .opacity(0.8)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                        .offset(y: -80)
                }

                // Bubble
                Image("bubble_text_1")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.6)
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    .offset(x: 90, y: -170)

                // Seaweed
                Image("seaweed")
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    .offset(x: 0, y: 230)
                    .scaleEffect(1.3)

                // Invisible NavigationLink untuk trigger programatik
                NavigationLink(destination: WelcomeView2(), isActive: $goToNext) {
                    EmptyView()
                }
            }
            .contentShape(Rectangle()) // Tap area seluruh ZStack
            .onTapGesture {
                goToNext = true
            }
            .onAppear {
                isAnimating = true
            }
        }
    }
}

#Preview {
    WelcomeView()
}
