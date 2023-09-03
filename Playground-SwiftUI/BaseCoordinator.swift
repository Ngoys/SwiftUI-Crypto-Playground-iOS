import SwiftUI
import Combine

class BaseCoordinator: ObservableObject, Hashable {

    //----------------------------------------
    // MARK: - Initialization
    //----------------------------------------

    init(path: NavigationPath) {
        self.path = path
    }

    //----------------------------------------
    // MARK: - Properties
    //----------------------------------------

    var cancellables = Set<AnyCancellable>()
    
    @Published var path: NavigationPath

    //----------------------------------------
    // MARK: - Hashable Protocols
    //----------------------------------------

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs.id == rhs.id
    }

    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------

    private let id = UUID()
}
