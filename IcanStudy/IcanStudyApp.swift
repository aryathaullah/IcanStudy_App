import SwiftUI
import SwiftData

@main
struct IcanStudyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
            }
        }
        .modelContainer(for: User.self)
    }
}
