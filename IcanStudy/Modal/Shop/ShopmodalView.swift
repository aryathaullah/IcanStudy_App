import SwiftUI

struct ShopItem: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let price: Int
}
var currentFishNames = FishStorageManager.getFishNames()

struct ShopmodalView: View {
    
    @State var showmodal = false
    let items: [ShopItem] = [
        ShopItem(name: "Sea Lion", imageName: "f1", price: 1000),
        ShopItem(name: "Shark", imageName: "f2", price: 850),
        ShopItem(name: "Turtle", imageName: "f3", price: 200),
        ShopItem(name: "Dolphin", imageName: "f4", price: 200),
        ShopItem(name: "Crab", imageName: "f5", price: 100),
        ShopItem(name: "Pufferfish", imageName: "f6", price: 100),
        ShopItem(name: "Clownfish", imageName: "f7", price: 100),
        ShopItem(name: "Seahorse", imageName: "f8", price: 100),
        ShopItem(name: "Octopus", imageName: "f9", price: 100),
        ShopItem(name: "Hammerhead", imageName: "f10", price: 100),
        ShopItem(name: "Tropical Fish", imageName: "f11", price: 100),
        ShopItem(name: "Striped Fisha", imageName: "f12", price: 100),
        ShopItem(name: "Clownfisha", imageName: "f13", price: 100),
        ShopItem(name: "Seahorsae", imageName: "f14", price: 100),
        ShopItem(name: "Octopuas", imageName: "f15", price: 100),
        ShopItem(name: "Hammerhaead", imageName: "f16", price: 100),
        ShopItem(name: "Tropicaal Fish", imageName: "f17", price: 100),
        ShopItem(name: "Stripead Fish", imageName: "f18", price: 100)
    ]

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    @State private var selectedItem: ShopItem? = nil

    var onItemSelected: ((ShopItem) -> Void)? = nil

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .blur(radius: 10)

            ZStack {
                ZStack {
                    Image("coins_indicator")
                        .resizable()
                    Text("0")
                        .padding(.leading, 35)
                }
                .frame(width: 129, height: 52)
                .padding(.top, -370)
                .padding(.leading, 250)

                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color(#colorLiteral(red: 0.792, green: 0.573, blue: 0.316, alpha: 1)))
                    .frame(width: 342, height: 460)

                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color(#colorLiteral(red: 1, green: 0.94, blue: 0.78, alpha: 1)))
                    .frame(width: 320, height: 440)
                    .shadow(color: .black.opacity(0.5), radius: 5)

                VStack {
                    
                    
                    ZStack {
                        
                            
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(Color(#colorLiteral(red: 0.94, green: 0.35, blue: 0.32, alpha: 1)))
                                .frame(width: 160, height: 50)
                            
                            Text("SHOP")
                                .font(Font.custom("Slackey-Regular", size: 33))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white)
                                .shadow(radius: 5, x: 5)
                        
                        
                        
                        
                        Button(action: {
                            currentFishNames.removeAll()
                            FishStorageManager.resetFishNames()
                            print("pip")
                            //nanti ini bkl bekerja, sementra utk reset button
                        }) {
                            Image("red_back_button")
                                .resizable()
                                .frame(width: 69, height: 69)
                                .padding()
                        }
                        .position(x: 350, y: 225)
                    }
                    .position(x:150, y: 125)
                    
                    

                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(items) { item in
                                VStack(spacing: 5) {
                                    Image(item.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 60)
                                        .background(Color.white.opacity(0.7))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))

                                    Button(action: {
                                        selectedItem = item
                                    }) {
                                        HStack(spacing: 4) {
                                            Image(systemName: "circle.fill")
                                                .resizable()
                                                .frame(width: 12, height: 12)
                                            Text("\(item.price)")
                                                .font(.system(size: 12, weight: .bold))
                                        }
                                        .padding(5)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                    }
                                }
                                .padding(5)
                                .background(Color.yellow.opacity(0.3))
                                .cornerRadius(12)
                                .shadow(radius: 2)
                            }
                        }
                        .padding()
                    }
                    .scrollIndicators(.visible)
                    .position(x:150, y: 10)

                    
                }
                .frame(width: 300, height: 685)
            }

            if let selectedItem = selectedItem {
                ConfirmationModalViews(
                    item: selectedItem,
                    onConfirm: {
//                        onItemSelected?(selectedItem)
                        print("Confirmed purchase of: \(selectedItem.name)")
                        currentFishNames.append(selectedItem.name)
                        FishStorageManager.saveFishNames(currentFishNames)
                        print(FishStorageManager.getFishNames())
                        self.selectedItem = nil
                    },
                    onCancel: { i in
                        if i == "cancel"{
                            print("ini \(i)")
                            self.selectedItem = nil
                        }
                        else if i == "no money"{
                            print("ini \(i)")
                            self.selectedItem = nil
                            showmodal = true
                        }
                    },
                    
                )
            }
            
            if showmodal {
                NoMoneyShop(onQuit:{
                    showmodal = false
                    print("keluar dri nomoney")
                    
                })
            }

        }
    }
}

struct ShopmodalView_Previews: PreviewProvider {
    static var previews: some View {
        ShopmodalView(onItemSelected: { item in
            print("Confirmed purchase m k  of: \(item.name)")
            currentFishNames.append("\(item.name)")
            FishStorageManager.saveFishNames(currentFishNames)
            print(FishStorageManager.getFishNames())
            
        })
    }
}




