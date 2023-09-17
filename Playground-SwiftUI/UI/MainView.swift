import SwiftUI
import Combine

struct MainView: View {
    @ObservedObject var usersFlowCoordinator: UserFlowCoordinator

    @ObservedObject var coinListingFlowCoordinator: CoinListingFlowCoordinator

    var body: some View {
        TabView {
            NavigationStack(path: $coinListingFlowCoordinator.path) {
                coinListingFlowCoordinator.build()
                    .navigationDestination(for: CoinDetailCoordinator.self) { coordinator in
                        coordinator.build()
                    }
            }
            .tabItem {
                Label("Coins", systemImage: "list.dash")
            }

            NavigationStack(path: $usersFlowCoordinator.path) {
                usersFlowCoordinator.build()
            }
            .tabItem {
                Label("Profile", systemImage: "square.and.pencil")
            }
        }
    }
}
