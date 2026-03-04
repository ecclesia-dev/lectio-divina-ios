import SwiftUI

struct ReadingSessionView: View {
    let passage: PassageReference
    @Environment(SessionStore.self) private var sessionStore
    @Environment(\.dismiss) private var dismiss

    @State private var currentStep: MeditationStep = .lectio
    @State private var secondsRemaining: Int = MeditationStep.lectio.durationSeconds
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var showCompletion = false

    private var passageText: String {
        BibleStore.shared.passageText(book: passage.book, chapter: passage.chapter)
    }

    private var overallProgress: Double {
        let completed = MeditationStep.allCases
            .filter { $0.rawValue < currentStep.rawValue }
            .reduce(0) { $0 + $1.durationSeconds }
        let currentElapsed = currentStep.durationSeconds - secondsRemaining
        return Double(completed + currentElapsed) / Double(MeditationStep.totalDuration)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Overall progress bar
                ProgressView(value: overallProgress)
                    .tint(.brown)

                if showCompletion {
                    completionView
                } else {
                    sessionContent
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("End") {
                        stopTimer()
                        dismiss()
                    }
                    .foregroundStyle(.secondary)
                }
            }
        }
        .onDisappear { stopTimer() }
    }

    // MARK: - Session Content

    private var sessionContent: some View {
        VStack(spacing: 32) {
            Spacer()

            // Step indicator
            HStack(spacing: 8) {
                ForEach(MeditationStep.allCases) { step in
                    Circle()
                        .fill(step.rawValue <= currentStep.rawValue ? Color.brown : Color.brown.opacity(0.2))
                        .frame(width: 8, height: 8)
                }
            }

            // Step title
            VStack(spacing: 8) {
                Text(currentStep.title)
                    .font(.system(.largeTitle, design: .serif))
                    .fontWeight(.bold)
                Text(currentStep.subtitle)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            // Timer
            Text(timeString(secondsRemaining))
                .font(.system(size: 56, weight: .light, design: .rounded))
                .monospacedDigit()
                .contentTransition(.numericText())

            // Prompt
            Text(currentStep.prompt)
                .font(.system(.body, design: .serif))
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
                .padding(.horizontal, 40)

            // Show passage text during Lectio
            if currentStep == .lectio {
                ScrollView {
                    Text(passageText)
                        .font(.system(.callout, design: .serif))
                        .lineSpacing(4)
                        .padding(.horizontal)
                }
                .frame(maxHeight: 200)
                .mask(
                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0),
                            .init(color: .black, location: 0.05),
                            .init(color: .black, location: 0.9),
                            .init(color: .clear, location: 1.0),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }

            Spacer()

            // Play/Pause
            Button {
                if isRunning { pauseTimer() } else { startTimer() }
            } label: {
                Image(systemName: isRunning ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(.brown)
            }
            .padding(.bottom, 40)
        }
        .animation(.easeInOut, value: currentStep)
    }

    // MARK: - Completion

    private var completionView: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "checkmark.circle")
                .font(.system(size: 72))
                .foregroundStyle(.brown)

            Text("Session Complete")
                .font(.system(.title, design: .serif))

            Text(passage.displayName)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()

            Button {
                dismiss()
            } label: {
                Text("Done")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .buttonStyle(.borderedProminent)
            .tint(.brown)
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }

    // MARK: - Timer Logic

    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if secondsRemaining > 0 {
                secondsRemaining -= 1
            } else {
                advanceStep()
            }
        }
    }

    private func pauseTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    private func advanceStep() {
        if let next = currentStep.next {
            currentStep = next
            secondsRemaining = next.durationSeconds
        } else {
            stopTimer()
            showCompletion = true
            sessionStore.add(Session(passageReference: passage.displayName))
        }
    }

    private func timeString(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return String(format: "%d:%02d", m, s)
    }
}
