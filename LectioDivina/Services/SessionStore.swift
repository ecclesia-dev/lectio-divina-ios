import Foundation
import SwiftUI

@Observable
final class SessionStore {
    private(set) var sessions: [Session] = []
    private let key = "lectio_divina_sessions"

    init() { load() }

    func add(_ session: Session) {
        sessions.insert(session, at: 0)
        save()
    }

    func hasSessionToday() -> Bool {
        let calendar = Calendar.current
        return sessions.contains { calendar.isDateInToday($0.date) }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Session].self, from: data) else { return }
        sessions = decoded
    }

    private func save() {
        if let data = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
