import Foundation
import Combine
import SwiftUI

class CoinListingViewModel: StatefulViewModel<[Coin]> {

    //----------------------------------------
    // MARK:- Initialization
    //----------------------------------------

    init(coinStore: CoinStore) {
        self.coinStore = coinStore
    }

    //----------------------------------------
    // MARK: - Data loading
    //----------------------------------------

    override func load() -> AnyPublisher<[Coin], Error> {
        return coinsSubject.eraseToAnyPublisher()
            .map { coins in
                return coins + [Coin(symbol: "XRPUSD", id: 0)]
            }.eraseToAnyPublisher()
    }

    func addCoins() {
        coinsSubject.send(coinsSubject.value + [Coin(symbol: "XRPUSD", id: coinsSubject.value.count + 1)])
    }

    func unsubcribeFetchCoins(coinName: String) -> AnyPublisher<Void, Error> {
        coinStore.unsubcribeFetchCoins(coinName: coinName)
    }

    func fetchCoins(coinName: String) -> AnyPublisher<[Coin], Error> {
        return coinStore.fetchCoins(coinName: coinName)
    }

    private let coinsSubject = CurrentValueSubject<[Coin], Error>([])
    
    private let coinStore: CoinStore
}
