import Foundation
import SwiftData

@Model
class User {
    var coins: Int
    var name: String
    
    init(coins: Int) {
        self.coins = coins
        self.name = ""
    }
}
