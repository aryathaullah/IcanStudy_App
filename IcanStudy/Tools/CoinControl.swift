import SwiftData

struct CoinControl{
    
    static func addCoins(context: ModelContext, amount: Int) {
            if let user = try? context.fetch(FetchDescriptor<User>()).first {
                user.coins += amount
            } else {
                context.insert(User(coins: amount))
            }
            try? context.save()
    }
    
    static func rewardCoins(forSeconds userTotalSeconds: Int, context: ModelContext) {
            let coinAmount = userTotalSeconds / 2
            if coinAmount > 0 {
                addCoins(context: context, amount: coinAmount)
            }
    }
    
}
