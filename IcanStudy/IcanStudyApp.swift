import SwiftUI
import SwiftData

@main
struct IcanStudyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ShopmodalView(onItemSelected: { i in
                    print(FishStorageManager.getFishNames())
                })
            }
        }
        .modelContainer(for: User.self)
    }
}
