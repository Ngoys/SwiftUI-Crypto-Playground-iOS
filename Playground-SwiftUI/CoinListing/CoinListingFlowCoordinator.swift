import SwiftUI
import Combine

enum CoinListingPage: String, Identifiable {
    case main
    case detail

    var id: String {
        self.rawValue
    }
}

class CoinListingFlowCoordinator: BaseCoordinator {
    @Published private var page: CoinListingPage

    init(path: NavigationPath, page: CoinListingPage) {
        self.page = page
        super.init(path: path)
    }
    
    @ViewBuilder
    func build() -> some View {
        switch page {
        case .main:
            coinListingView()

        case .detail:
            CoinDetailCoordinator(path: path).build()
        }
    }

    private func coinListingView() -> some View {
        let view = CoinListingView(viewModel: CoinListingViewModel(coinStore: CoinStore(socketAPIClient: CoinSocketAPIClient())))

        view.coinDidTap
            .sink(receiveValue: { [weak self] coin in
                guard let self = self else { return }
                path.append(CoinDetailCoordinator(path: path))
            })
            .store(in: &cancellables)
        
        return view
    }
}
