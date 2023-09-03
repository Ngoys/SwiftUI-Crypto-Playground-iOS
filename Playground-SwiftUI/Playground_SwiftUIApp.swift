import SwiftUI

@main
struct Playground_SwiftUIApp: App {

    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            appCoordinator.build()
        }
    }
}
