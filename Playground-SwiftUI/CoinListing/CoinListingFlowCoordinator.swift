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
    @Published var path: NavigationPath
    
    @Published private var page: CoinListingPage

    init(path: NavigationPath, page: CoinListingPage) {
        self.path = path
        self.page = page
    }
    
    @ViewBuilder
    func build() -> some View {
        switch page {
        case .main:
            coinListingView()

        case .detail:
            getCoinDetailCoordinator().build()
        }
    }

    private func coinListingView() -> some View {
        let view = CoinListingView(viewModel: CoinListingViewModel(coinStore: CoinStore(socketAPIClient: CoinSocketAPIClient())))

        view.coinDidTap
            .sink(receiveValue: { [weak self] coin in
                guard let self = self else { return }
                path.append(getCoinDetailCoordinator())
            })
            .store(in: &cancellables)
        
        return view
    }
}
