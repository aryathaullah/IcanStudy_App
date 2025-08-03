import SwiftUI

struct SlidersView: View {
    @State private var showShopPopup = false
    @Environment(\.dismiss) private var dismiss

    // Waktu yang dipilih
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    @State private var selectedSecond = 0
    
    @State private var selectedTotalSeconds = 0

    var body: some View {
        ZStack {
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

            VStack(spacing: 10) {
                Text("Today's Study Time")
                    .font(Font.custom("Slackey-Regular", size: 24))
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)

                // Timer Picker (jam, menit, detik)
                HStack(spacing: 10) {
                    Picker(selection: $selectedHour, label: Text("Hour")) {
                        ForEach(0..<24, id: \.self) { hour in
                            Text(String(format: "%02d", hour))
                                .font(Font.custom("Slackey-Regular", size: 24))
                                .foregroundColor(.white)
                                .tag(hour)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 80, height: 120)
                    .clipped()
                    
                    Text(":")
                        .font(Font.custom("Slackey-Regular", size: 24))
                        .foregroundColor(.white)

                    Picker(selection: $selectedMinute, label: Text("Minute")) {
                        ForEach(0..<60, id: \.self) { minute in
                            Text(String(format: "%02d", minute))
                                .font(Font.custom("Slackey-Regular", size: 24))
                                .foregroundColor(.white)
                                .tag(minute)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 80, height: 120)
                    .clipped()
                    
                    Text(":")
                        .font(Font.custom("Slackey-Regular", size: 24))
                        .foregroundColor(.white)

                    Picker(selection: $selectedSecond, label: Text("Second")) {
                        ForEach(0..<60, id: \.self) { second in
                            Text(String(format: "%02d", second))
                                .font(Font.custom("Slackey-Regular", size: 24))
                                .foregroundColor(.white)
                                .tag(second)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 80, height: 120)
                    .clipped()
                }


                Button(action: {
                    selectedTotalSeconds = selectedHour * 3600 + selectedMinute * 60 + selectedSecond
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
            .offset(y: -100)

            if showShopPopup {
                PreparationModalView(isPresented: $showShopPopup, totalSeconds: selectedTotalSeconds)
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
