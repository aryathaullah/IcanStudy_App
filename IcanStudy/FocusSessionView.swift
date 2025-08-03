import SwiftUI

struct FocusSessionView: View {
    @State private var showShopPopup = false
    @Environment(\.dismiss) private var dismiss

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

                Text("00:00:00")
                    .font(Font.custom("Slackey-Regular", size: 53))
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                
                Spacer()
                    .frame(height: 70)

                Button(action: {
                    print("quit")
                }) {
                    ZStack {
                        Image("button_quit")
                            .resizable()
                            .frame(width: 180, height: 52)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    print("break")
                }) {
                    ZStack {
                        Image("button_break")
                            .resizable()
                            .frame(width: 218, height: 52)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }

            if showShopPopup {
                PreparationModalView(isPresented: $showShopPopup)
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image("back_button")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .padding(.top, 65)
                }
            }
        }
    }
}

#Preview {
    FocusSessionView()
}
