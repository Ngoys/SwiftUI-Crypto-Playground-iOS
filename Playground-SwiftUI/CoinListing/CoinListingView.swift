import SwiftUI
import Combine

struct CoinListingView: View {
    
    @StateObject var viewModel: CoinListingViewModel

    @State private var coins: [Coin] = []
    @State private var coinError: Error?

    @State private var tradingCoins: [Coin] = []
    @State private var tradingCoinsError: Error?

    @State private var testingTradingCoins: [Coin] = []
    @State private var testingTradingCoinsError: Error?

    @State private var cancellables = Set<AnyCancellable>()

    let coinDidTapSubject = PassthroughSubject<Coin, Never>()

    @ViewBuilder
    var body: some View {
//        List(tradingCoins) { coin in
//            Text(verbatim: coin.symbol)
//        }
//        .onAppear(perform: {
//        tradingCoins.removeAll()
//            viewModel.fetchCoins(coinName: "XBTUSD").sink { completion in
//                switch completion {
//                case .finished:
//                    break
//
//                case .failure(let error):
//                    tradingCoinsError = error
//                }
//            } receiveValue: { data in
//                tradingCoins.append(contentsOf: data)
//            }.store(in: &cancellables)
//        })
//        .onDisappear {
//            viewModel.unsubcribeFetchCoins(coinName: "XBTUSD").sink { completion in
//                switch completion {
//                case .finished:
//                    break
//
//                case .failure(let error):
//                    tradingCoinsError = error
//                }
//            } receiveValue: { _ in
//            }.store(in: &cancellables)
//        }

        List(testingTradingCoins) { coin in
            Text(verbatim: coin.symbol)
        }
        .onAppear(perform: {
            testingTradingCoins.removeAll()
            viewModel.fetchCoins(coinName: "XRPUSD").sink { completion in
                switch completion {
                case .finished:
                    break

                case .failure(let error):
                    testingTradingCoinsError = error
                }
            } receiveValue: { data in
                testingTradingCoins.append(contentsOf: data)
            }.store(in: &cancellables)
        })
        .onDisappear {
            viewModel.unsubcribeFetchCoins(coinName: "XRPUSD").sink { completion in
                switch completion {
                case .finished:
                    break

                case .failure(let error):
                    tradingCoinsError = error
                }
            } receiveValue: { _ in
            }.store(in: &cancellables)
        }

        ZStack {
            List(coins) { coin in
                let viewModel = CoinListingRowViewModel(coin: coin)
                CoinListingRow(viewModel: viewModel) {
                    coinDidTapSubject.send(coin)
                    print("coinDidTap")

                    self.viewModel.addCoins()
                }
            }

            if let coinError = coinError {
                Text(verbatim: "Error la")
            }
        }
        .onReceive(viewModel.statePublisher) { state in
            switch (state) {
                //                self.statefulPlaceholderView.bind(state)

            case .loaded(let coinss):
                coins = coinss

                // Fake
//                if coinss.count > 2 {
//                    coinError = AppError.emptySearchResult
//                }

            default:
                break
            }
        }
    }
}
