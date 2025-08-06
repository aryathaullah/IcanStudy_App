import SwiftUI

struct QuitModalView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    var totalSeconds: Int
    var remainingSeconds: Int
    var studiedSeconds: Int
    var onContinue: () -> Void
    
    @State private var modalConfirmation = false
    @State private var backFocusConfirmation = false
    
    @State private var autoContinueSeconds = 5
    @State private var autoContinueTimer: Timer? = nil
    
    var formattedTime: String {
        let hours = studiedSeconds / 3600
        let minutes = (studiedSeconds % 3600) / 60
        let seconds = studiedSeconds % 60
        
        return String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }
    
    var body: some View {
        ZStack {
            
            // background blur
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .blur(radius: 10)
            
            // modal preparation
            ZStack{
                
                // dark brown background
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color(#colorLiteral(red: 0.7920315862, green: 0.5732310414, blue: 0.3168769479, alpha: 1)))
                    .frame(width: 322, height: 430)
                
                // light brown background
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color(#colorLiteral(red: 1, green: 0.940058589, blue: 0.7803176045, alpha: 1)))
                    .frame(width: 295, height: 380)
                    .shadow(color: .black.opacity(0.5), radius: 5)
                
                // modal title
                ZStack{
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(Color(#colorLiteral(red: 0.9135003686, green: 0.2600500882, blue: 0.2565283477, alpha: 1)))
                        .frame(width: 172, height: 43)
                        .shadow(color: .black.opacity(0.5), radius: 5)
                    
                    Text("QUIT")
                        .font(Font.custom("Slackey-Regular", size: 31))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .shadow(radius: 5, x: 5)
                    
                }
                .offset(y: -200)
             
            
    
                Button(action: {
                        stopAutoContinueCountdown()
                        isPresented = false
                        onContinue()
                }) {
                    Image("red_back_button")
                        .resizable()
                        .frame(width: 69, height: 69)
                        .padding()
                }
                .position(x: 360, y: 275)
                
                
                VStack {
                    Text("STUDY TIME")
                        .font(Font.custom("Slackey-Regular", size: 15))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))

                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(Color(#colorLiteral(red: 0.9668874145, green: 0.9050707221, blue: 0.7431390882, alpha: 1)))
                            .frame(width: 220, height: 42)

                        Text(formattedTime)
                            .font(Font.custom("Slackey-Regular", size: 29))
                            .fontWeight(.bold)
                            .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                    }
                    .offset(y: -10)
                }
                .offset(y: -100)
                
                VStack {
                    Text("REWARD")
                        .font(Font.custom("Slackey-Regular", size: 15))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                        .offset(y:-7)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(Color(#colorLiteral(red: 0.9668874145, green: 0.9050707221, blue: 0.7431390882, alpha: 1)))
                            .frame(width: 220, height: 42)

                        HStack {
                            
                            Image("Seashell")
                                  .scaledToFit()
                                  .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                                  .frame(width: 20, height: 20)
                                  .offset(x:-10)
                                    
                            
                            Text("\(CoinControl.calcCoins(forSeconds: studiedSeconds))")
                                .font(Font.custom("Slackey-Regular", size: 29))
                                .fontWeight(.bold)
                                .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                            
                            
                        }
                    }
                    .offset(y: -15)
                }
                .offset(y: -20)

                
                
                // QUIT TEXT
                VStack(alignment: .leading, spacing: 15) {
                    
                  
                    HStack {
                        Text("If the session is less than 5 mins, no rewards will be given (continue study in \(autoContinueSeconds)).")
                            .foregroundStyle(Color(#colorLiteral(red: 0.4227513969, green: 0.2634371519, blue: 0, alpha: 1)))
                            .shadow(radius: 5, x: 5)
                            .multilineTextAlignment(.center)
                            .offset(y:-40)

                    }
                    
                    
                    SlideToConfirmButton {
                        dismiss()
                        StudySessionManager.addSession(studiedSeconds: studiedSeconds, context: modelContext)
                        CoinControl.rewardCoins(forSeconds: studiedSeconds, context: modelContext)
                    }
                    .offset(y: -30)

                    
                } 
                .font(Font.custom("Slackey-Regular", size: 16))
                .padding(.top, 250)
                .padding(.horizontal, 80)
        }
            
        }
        .transition(.opacity)
        .animation(.easeInOut, value: isPresented)
        .onAppear {
            startAutoContinueCountdown()
        }
        .onDisappear {
            stopAutoContinueCountdown()
        }
    }
    
    func startAutoContinueCountdown() {
        autoContinueTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if autoContinueSeconds > 0 {
                autoContinueSeconds -= 1
            } else {
                stopAutoContinueCountdown()
                isPresented = false
                onContinue()
            }
        }
    }

    func stopAutoContinueCountdown() {
        autoContinueTimer?.invalidate()
        autoContinueTimer = nil
    }
}

#Preview {
    QuitModalView(
        isPresented: .constant(true),
        totalSeconds: 600,
        remainingSeconds: 300,
        studiedSeconds: 300
    ) {
        print("✅ Continue pressed")
    }
    .modelContainer(for: [User.self, StudySession.self], inMemory: true) // tambahkan ini jika pakai SwiftData
}
