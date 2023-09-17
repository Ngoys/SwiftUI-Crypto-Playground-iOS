import SwiftUI
import Combine

class CoinDetailCoordinator: BaseCoordinator {

    @ViewBuilder
    func build() -> some View {
        coinDetailView()
    }

    private func coinDetailView() -> some View {
        let view = CoinDetailView()
        return view
    }
}
