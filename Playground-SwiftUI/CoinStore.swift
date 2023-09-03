import Foundation
import Combine

class CoinStore: BaseStore {

    //----------------------------------------
    // MARK: - Initialization
    //----------------------------------------

    init(socketAPIClient: SocketAPIClient) {
        self.socketAPIClient = socketAPIClient
    }

    //----------------------------------------
    // MARK: - Actions
    //----------------------------------------

    func fetchCoins(coinName: String) -> AnyPublisher<[Coin], Error> {
        let publisher = socketAPIClient.apiRequest(AppConstant.socketAPIURL,
                                                   operation: .subscribe,
                                                   arguments: ["orderBookL2_25:\(coinName)"])
            .tryMap { data -> [Coin] in
                guard let modal = try? JSONDecoder().decode(CoinSocketAPIJSON<[Coin]>.self, from: data) else {
                    return []
                }
                return modal.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

        return publisher
    }

    func unsubcribeFetchCoins(coinName: String) -> AnyPublisher<Void, Error> {
        let publisher = socketAPIClient.apiRequest(AppConstant.socketAPIURL,
                                                   operation: .unsubscribe,
                                                   arguments: ["orderBookL2_25:\(coinName)"])
            .tryMap { data -> () in
                return ()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

        return publisher
    }

    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------

    private let socketAPIClient: SocketAPIClient
}
