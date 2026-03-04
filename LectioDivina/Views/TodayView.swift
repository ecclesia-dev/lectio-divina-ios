import SwiftUI

struct TodayView: View {
    @Environment(SessionStore.self) private var sessionStore
    @State private var showSession = false
    @State private var showPassage = false

    private let passage = PassageSchedule.today()
    private var passageText: String {
        BibleStore.shared.passageText(book: passage.book, chapter: passage.chapter)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Lectio Divina")
                            .font(.system(.largeTitle, design: .serif))
                            .fontWeight(.bold)
                        Text(Date.now, format: .dateTime.weekday(.wide).month(.wide).day())
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 24)

                    // Today's passage card
                    VStack(spacing: 16) {
                        Text("Today's Reading")
                            .font(.caption)
                            .textCase(.uppercase)
                            .tracking(1.5)
                            .foregroundStyle(.secondary)

                        Text(passage.displayName)
                            .font(.system(.title2, design: .serif))

                        if sessionStore.hasSessionToday() {
                            Label("Completed", systemImage: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                                .font(.subheadline)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))

                    // Action buttons
                    VStack(spacing: 12) {
                        Button {
                            showSession = true
                        } label: {
                            Label("Begin Sacred Reading", systemImage: "play.fill")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.brown)

                        Button {
                            showPassage = true
                        } label: {
                            Label("Read Passage", systemImage: "text.book.closed")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                        }
                        .buttonStyle(.bordered)
                        .tint(.brown)
                    }

                    // Steps overview
                    VStack(alignment: .leading, spacing: 12) {
                        Text("The Four Steps")
                            .font(.caption)
                            .textCase(.uppercase)
                            .tracking(1.5)
                            .foregroundStyle(.secondary)

                        ForEach(MeditationStep.allCases) { step in
                            HStack(spacing: 12) {
                                Text("\(step.rawValue + 1)")
                                    .font(.system(.caption, design: .serif))
                                    .fontWeight(.bold)
                                    .frame(width: 24, height: 24)
                                    .background(Circle().fill(.brown.opacity(0.15)))

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("\(step.title) — \(step.subtitle)")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    Text("\(step.durationSeconds / 60) min")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }

                                Spacer()
                            }
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
            .fullScreenCover(isPresented: $showSession) {
                ReadingSessionView(passage: passage)
            }
            .sheet(isPresented: $showPassage) {
                PassageTextView(passage: passage, text: passageText)
            }
        }
    }
}

// MARK: - Passage Text Sheet

struct PassageTextView: View {
    let passage: PassageReference
    let text: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                Text(text)
                    .font(.system(.body, design: .serif))
                    .lineSpacing(6)
                    .padding()
            }
            .navigationTitle(passage.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
