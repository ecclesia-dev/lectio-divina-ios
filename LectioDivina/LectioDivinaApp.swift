import SwiftUI

@main
struct LectioDivinaApp: App {
    @State private var sessionStore = SessionStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(sessionStore)
        }
    }
}
