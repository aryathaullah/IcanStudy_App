import SwiftUI
import SwiftData
import AVFoundation

struct FocusSessionView: View {
    @Environment(\.modelContext) private var modelContext

    @Binding var isPresented: Bool
    let initialSeconds: Int

    @State private var remainingSeconds: Int
    @State private var timer: Timer?
    @State private var studiedSeconds: Int = 0
    @State private var breakLimit = 0

    @State private var showQuitModal = false
    @State private var breakConfirmation = false
    @State private var finishConfirmation = false

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

            FishAnimationView(refreshFish: .constant(false))

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
                    breakConfirmation = true
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
            stopBackgroundMusic() // Jaga-jaga kalau sebelumnya belum berhenti
            playBackgroundMusic()
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
            stopBackgroundMusic()
        }

        if showQuitModal {
            QuitModalView(
                isPresented: $showQuitModal,
                totalSeconds: initialSeconds,
                remainingSeconds: remainingSeconds,
                studiedSeconds: studiedSeconds,
                onContinue: {
                    stopBackgroundMusic() // ini untuk continue
                    resumeTimer()
                },
                onQuit: {
                    stopBackgroundMusic() // ini untuk quit
                }
            )
        }


        if breakConfirmation {
            BreakConfirmation(
                isPresented: $breakConfirmation,
                totalSeconds: initialSeconds,
                RemainingSeconds: remainingSeconds,
                studiedSeconds: studiedSeconds,
                breakLimit: $breakLimit,
                onContinue: {
                    resumeTimer()
                }
            )
        }

        if finishConfirmation {
            FinishModalView(
                isPresented: $finishConfirmation,
                totalSeconds: initialSeconds,
                RemainingSeconds: remainingSeconds
            )
        }
    }

    // MARK: - Timer Logic

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
                studiedSeconds += 1
            } else {
                timer?.invalidate()
                stopBackgroundMusic()
                finishConfirmation = true
                StudySessionManager.addSession(studiedSeconds: studiedSeconds, context: modelContext)
                CoinControl.rewardCoins(forSeconds: initialSeconds, context: modelContext)
            }
        }
    }

    private func resumeTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
                studiedSeconds += 1
            } else {
                timer?.invalidate()
                stopBackgroundMusic()
                finishConfirmation = true
                StudySessionManager.addSession(studiedSeconds: studiedSeconds, context: modelContext)
                CoinControl.rewardCoins(forSeconds: initialSeconds, context: modelContext)
            }
        }
    }

    // MARK: - Audio Logic

    private func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "underwatersounds", withExtension: "mp3") else {
            print("🎵 Audio file not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // infinite loop
            audioPlayer?.play()
        } catch {
            print("❌ Failed to play audio: \(error.localizedDescription)")
        }
    }

    private func stopBackgroundMusic() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}
