import UIKit
import Combine

class BaseViewModel: ObservableObject {

    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------

    var cancellables: Set<AnyCancellable> = Set()
}
