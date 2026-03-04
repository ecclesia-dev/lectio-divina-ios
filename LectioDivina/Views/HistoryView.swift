import SwiftUI

struct HistoryView: View {
    @Environment(SessionStore.self) private var sessionStore

    var body: some View {
        NavigationStack {
            Group {
                if sessionStore.sessions.isEmpty {
                    ContentUnavailableView(
                        "No Sessions Yet",
                        systemImage: "clock",
                        description: Text("Complete your first lectio divina\nto see it here.")
                    )
                } else {
                    List(sessionStore.sessions) { session in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(session.passageReference)
                                    .font(.system(.body, design: .serif))
                                Text(session.date, format: .dateTime.weekday(.wide).month(.abbreviated).day().year())
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            if session.completed {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("History")
        }
    }
}
