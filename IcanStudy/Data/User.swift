import Foundation
import SwiftData

@Model
public class User {
    public var coins: Int
    
    public init(coins: Int) {
        self.coins = coins
    }
}
