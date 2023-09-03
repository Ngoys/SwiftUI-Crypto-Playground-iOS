import SwiftUI
import Combine

class BaseCoordinator: ObservableObject, Hashable {

    //----------------------------------------
    // MARK: - Properties
    //----------------------------------------

    var cancellables = Set<AnyCancellable>()

    //----------------------------------------
    // MARK: - Actions
    //----------------------------------------

    func getCoinDetailCoordinator() -> CoinDetailCoordinator {
        let coordinator = CoinDetailCoordinator()
        return coordinator
    }

    func getCoinListingFlowCoordinator(path: NavigationPath, page: CoinListingPage) -> CoinListingFlowCoordinator {
        let coordinator = CoinListingFlowCoordinator(path: path, page: page)
        return coordinator
    }

    func getUserFlowCoordinator(path: NavigationPath, page: UserPage) -> UserFlowCoordinator {
        let coordinator = UserFlowCoordinator(path: path, page: page)
        return coordinator
    }

    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------

    private let id = UUID()
}

extension BaseCoordinator {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs.id == rhs.id
    }
}
