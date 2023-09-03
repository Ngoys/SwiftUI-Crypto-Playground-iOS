import SwiftUI
import Combine

class BaseView: View {

    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------

    var cancellables: Set<AnyCancellable> = Set()
}
