import SwiftUI

struct QuitModalView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    
    @State private var modalConfirmation = false
    
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
                    .frame(width: 322, height: 322)
                
                // light brown background
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color(#colorLiteral(red: 1, green: 0.940058589, blue: 0.7803176045, alpha: 1)))
                    .frame(width: 302, height: 289)
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
                .offset(y: -150)
                
                Button(action: {
                    isPresented = false
                }) {
                    Image("red_back_button")
                        .resizable()
                        .frame(width: 69, height: 69)
                        .padding()
                }
                .position(x: 360, y: 240)
                
                
                // QUIT TEXT
                VStack(alignment: .leading, spacing: 15) {
                    
                    // TEXT 1
                    HStack {
                        Text("Are you sure you want to quit the session?")
                            .foregroundStyle(Color(#colorLiteral(red: 0.4227513969, green: 0.2634371519, blue: 0, alpha: 1)))
                            .shadow(radius: 5, x: 5)
                            .multilineTextAlignment(.center)
                            .offset(y:-50)

                    }
                    
                  
                    HStack {
                        Text("If the session is less than 5 mins, no rewards will be given.")
                            .foregroundStyle(Color(#colorLiteral(red: 0.4227513969, green: 0.2634371519, blue: 0, alpha: 1)))
                            .shadow(radius: 5, x: 5)
                            .multilineTextAlignment(.center)
                            .offset(y:-40)

                    }
                    
                    
                    SlideToConfirmButton {
                        dismiss()
                    }
                    .offset(y: -30)

                    
                } // end of checklist
                .font(Font.custom("Slackey-Regular", size: 16))
                .padding(.top, 120)
                .padding(.horizontal, 80)
        }
            
        }
        .transition(.opacity)
        .animation(.easeInOut, value: isPresented)
    }
}

#Preview {
    QuitModalView(isPresented: .constant(true))
}
