import SwiftUI

struct FocusSessionView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isPresented: Bool
    let initialSeconds: Int

    @State private var remainingSeconds: Int
    @State private var timer: Timer?

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
            // Background utama
            Image("background_app")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                HStack {
                    Image("coins_indicator")
                        .resizable()
                        .frame(width: 129, height: 52)
                        .padding(.top, 50)
                        .padding(.leading, 250)
                }
                Spacer()
            }

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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    timer?.invalidate()
                    dismiss()
                }) {
                    Image("back_button")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .padding(.top, 65)
                }
            }
        }
        .onAppear {
            startTimer()
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
}
