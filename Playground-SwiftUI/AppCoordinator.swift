import SwiftUI
import Combine

class AppCoordinator: BaseCoordinator {

    @ViewBuilder
    func build() -> some View {
        mainView()
    }

    private func mainView() -> some View {
        let view = MainView(usersFlowCoordinator: UserFlowCoordinator(path: path, page: .main), coinListingFlowCoordinator: CoinListingFlowCoordinator(path: path, page: .main))
        
        return view
    }
}
