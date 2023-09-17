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
    
    @State var page: UserPage

    init(path: NavigationPath, page: UserPage) {
        self.page = page
        super.init(path: path)
    }

    @ViewBuilder
    func build() -> some View {
        switch self.page {
        case .main:
            Text("Hello World")
        }
    }
}
