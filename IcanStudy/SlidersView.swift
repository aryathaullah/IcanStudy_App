import SwiftUI

struct SlidersView: View {
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
                Text("Today's Study Time")
                    .font(Font.custom("Slackey-Regular", size: 24))
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)

                Text("00:00:00")
                    .font(Font.custom("Slackey-Regular", size: 53))
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)

                Button(action: {
                    showShopPopup = true
                }) {
                    ZStack {
                        Image("button_confirmation")
                            .resizable()
                            .frame(width: 180, height: 52)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                        Text("START")
                            .font(Font.custom("Slackey-Regular", size: 33))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .offset(y: -125)

            // Tampilkan popup jika showShopPopup == true
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
    SlidersView()
}
