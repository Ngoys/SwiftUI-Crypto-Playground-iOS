import SwiftUI
import Combine

// Enum to identify User flow screen Types
enum UserPage: String, Identifiable {
    case main

    var id: String {
        self.rawValue
    }
}

class UserFlowCoordinator: BaseCoordinator {

    @Published var path: NavigationPath
    
    @Published var page: UserPage

    init(path: NavigationPath, page: UserPage) {
        self.path = path
        self.page = page
    }

    @ViewBuilder
    func build() -> some View {
        switch self.page {
        case .main:
            Text("meow")
        }
    }
}
