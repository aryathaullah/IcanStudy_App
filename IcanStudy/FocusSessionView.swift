import SwiftUI
import SwiftData
import AVFoundation

struct FocusSessionView: View {
    @Environment(\.modelContext) private var modelContext

    @Binding var isPresented: Bool
    let initialSeconds: Int

    @State private var remainingSeconds: Int
    @State private var timer: Timer?
    @State private var showQuitModal = false
    
    @State private var audioPlayer: AVAudioPlayer?
    


    init(isPresented: Binding<Bool>, totalSeconds: Int) {
        self._isPresented = isPresented
        self.initialSeconds = totalSeconds
        self._remainingSeconds = State(initialValue: totalSeconds)
    }

    var body: some View {
        ZStack {
            
            Image("background_app")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            FishAnimationView()

            VStack {
                Text(TimeFormatterHelper.formatTime(seconds: remainingSeconds))
                    .font(Font.custom("Slackey-Regular", size: 53))
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)

                Spacer()
                    .frame(height: 70)

                Button(action: {
                    timer?.invalidate()
                    showQuitModal = true
                }) {
                    Image("button_quit")
                        .resizable()
                        .frame(width: 180, height: 52)
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                }
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    timer?.invalidate()
                    print("Break pressed")
                    
                }) {
                    Image("button_break")
                        .resizable()
                        .frame(width: 218, height: 52)
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }

        .onAppear {
            startTimer()
            AudioHelper.playSound(named: "start_sound")
        }
        .onDisappear {
            timer?.invalidate()
        }
        
        if showQuitModal {
                QuitModalView(isPresented: $showQuitModal)
        }
        
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                timer?.invalidate()
                CoinControl.rewardCoins(forSeconds: initialSeconds, context: modelContext)
            }
        }
    }
}
