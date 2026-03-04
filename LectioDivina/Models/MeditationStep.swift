import Foundation

enum MeditationStep: Int, CaseIterable, Identifiable {
    case lectio
    case meditatio
    case oratio
    case contemplatio

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .lectio: "Lectio"
        case .meditatio: "Meditatio"
        case .oratio: "Oratio"
        case .contemplatio: "Contemplatio"
        }
    }

    var subtitle: String {
        switch self {
        case .lectio: "Read"
        case .meditatio: "Meditate"
        case .oratio: "Pray"
        case .contemplatio: "Contemplate"
        }
    }

    var prompt: String {
        switch self {
        case .lectio:
            "Read the passage slowly.\nLet the words sink in."
        case .meditatio:
            "Reflect on the passage.\nWhat word or phrase stands out?"
        case .oratio:
            "Speak to God about what\nyou have read and pondered."
        case .contemplatio:
            "Rest in God's presence.\nBe still and listen."
        }
    }

    var durationSeconds: Int {
        switch self {
        case .lectio: 180       // 3 min
        case .meditatio: 300    // 5 min
        case .oratio: 300       // 5 min
        case .contemplatio: 120 // 2 min
        }
    }

    var next: MeditationStep? {
        MeditationStep(rawValue: rawValue + 1)
    }

    static var totalDuration: Int {
        allCases.reduce(0) { $0 + $1.durationSeconds }
    }
}
