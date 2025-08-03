import SwiftUI
import AVFoundation

struct FocusSessionView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isPresented: Bool
    let initialSeconds: Int

    @State private var remainingSeconds: Int
    @State private var timer: Timer?
    
    @State private var audioPlayer: AVAudioPlayer?


    init(isPresented: Binding<Bool>, totalSeconds: Int) {
        self._isPresented = isPresented
        self.initialSeconds = totalSeconds
        self._remainingSeconds = State(initialValue: totalSeconds)
    }

    var formattedTime: String {
        let hours = remainingSeconds / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }

    var body: some View {
        ZStack {
            
            Image("background_app")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            FishAnimationView()

            VStack {
                Text(formattedTime)
                    .font(Font.custom("Slackey-Regular", size: 53))
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)

                Spacer()
                    .frame(height: 70)

                Button(action: {
                    timer?.invalidate()
                    print("Quit pressed")
                    dismiss()
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
                    // Add break logic here
                }) {
                    Image("button_break")
                        .resizable()
                        .frame(width: 218, height: 52)
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startTimer()
            playSound()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                timer?.invalidate()
                print("Timer finished!")
                // You can add completion logic here
            }
        }
    }
    
    func playSound() {
        if let soundURL = Bundle.main.url(forResource: "start_sound", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Gagal memutar audio: \(error.localizedDescription)")
            }
        }
    }
}
