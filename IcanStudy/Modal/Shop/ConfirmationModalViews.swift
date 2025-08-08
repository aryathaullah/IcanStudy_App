import SwiftUI
import SwiftData

struct ConfirmationModalViews: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Query private var users: [User]
    
    let item: ShopItem
    let onConfirm: () -> Void
    let onCancel: (_ message:String) -> Void
    
    var body: some View {
        
        
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()

            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color(#colorLiteral(red: 0.792, green: 0.573, blue: 0.316, alpha: 1)))
                .frame(width: 302, height: 300)

            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color(#colorLiteral(red: 1, green: 0.94, blue: 0.78, alpha: 1)))
                .frame(width: 280, height: 280)
                .shadow(color: .black.opacity(0.5), radius: 5)
            
            VStack(spacing: 20) {
                Text("Confirm Purchase?")
                    .font(.title2)
                    .bold()

                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                 
                    .clipShape(RoundedRectangle(cornerRadius: 15))

                Text("Buy \(item.name) for \(item.price) coins?")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(width:300)

                HStack(spacing: 20) {
                    Button("Cancel") {
                        onCancel("cancel")
                    }
//                    .padding()
                    .frame(width: 100, height: 40)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("Buy") {
                            if let coin = users.first?.coins {
                                print("User has \(coin) coins")
                                if coin >= item.price {
                                    onConfirm()
                                } else {
                                    // Not enough coins
                                    onCancel("no money")
                                    print("Insufficient coins")
                                }
                            }
                        }
                        .frame(width: 100, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    .padding()
                    .frame(width: 100,height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    
                }
            }
            .padding()
            .frame(width: 300)
            

        }
    }
}



