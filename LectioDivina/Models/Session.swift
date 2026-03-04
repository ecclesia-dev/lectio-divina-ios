import Foundation

struct Session: Identifiable, Codable {
    let id: UUID
    let date: Date
    let passageReference: String
    let completed: Bool

    init(id: UUID = UUID(), date: Date = .now, passageReference: String, completed: Bool = true) {
        self.id = id
        self.date = date
        self.passageReference = passageReference
        self.completed = completed
    }
}
