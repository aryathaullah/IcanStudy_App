import SwiftUI

struct ShopPopupView: View {
    var onClose: () -> Void // closure untuk menutup popup dari parent

    var body: some View {
        ZStack {
            // Blur latar belakang
            VisualEffectBlur()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 16) {
                Image("shop_modal_image") // Ganti sesuai gambar kamu
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280)

                Button(action: {
                    onClose()
                }) {
                    Text("Close")
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .shadow(radius: 4)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
        }
    }
}

#Preview {
    ShopPopupView(onClose: {})
}
