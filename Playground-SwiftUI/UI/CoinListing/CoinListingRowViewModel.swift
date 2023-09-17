import Foundation
import UIKit

class CoinListingRowViewModel: BaseViewModel {

    //----------------------------------------
    // MARK: - Initialization
    //----------------------------------------

    init(coin: Coin) {
        self.coin = coin
    }

    //----------------------------------------
    // MARK: - Presentation
    //----------------------------------------

    var titleText: String {
        return "Coin id is \(self.coin.id)"
    }

    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------

    private let coin: Coin
}
