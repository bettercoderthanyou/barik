import SwiftUI

@main
struct BarikApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        BarikCLI.handleIfNeeded()
    }

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
