import SwiftUI

struct SettingsView: View {
    @AppStorage("reminder_enabled") private var reminderEnabled = false
    @AppStorage("reminder_hour") private var reminderHour = 7
    @AppStorage("reminder_minute") private var reminderMinute = 0
    @State private var permissionDenied = false

    private var reminderTime: Binding<Date> {
        Binding(
            get: {
                var components = DateComponents()
                components.hour = reminderHour
                components.minute = reminderMinute
                return Calendar.current.date(from: components) ?? .now
            },
            set: { newValue in
                let components = Calendar.current.dateComponents([.hour, .minute], from: newValue)
                reminderHour = components.hour ?? 7
                reminderMinute = components.minute ?? 0
                if reminderEnabled {
                    NotificationManager.shared.scheduleDailyReminder(hour: reminderHour, minute: reminderMinute)
                }
            }
        )
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Daily Reminder", isOn: $reminderEnabled)
                        .onChange(of: reminderEnabled) { _, enabled in
                            if enabled {
                                Task {
                                    let granted = await NotificationManager.shared.requestPermission()
                                    if granted {
                                        NotificationManager.shared.scheduleDailyReminder(
                                            hour: reminderHour, minute: reminderMinute
                                        )
                                    } else {
                                        permissionDenied = true
                                        reminderEnabled = false
                                    }
                                }
                            } else {
                                NotificationManager.shared.cancelReminder()
                            }
                        }

                    if reminderEnabled {
                        DatePicker("Time", selection: reminderTime, displayedComponents: .hourAndMinute)
                    }
                } header: {
                    Text("Notifications")
                } footer: {
                    Text("Receive a gentle daily reminder for your sacred reading.")
                }

                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("About Lectio Divina")
                            .font(.headline)
                        Text("An ancient Benedictine practice of sacred reading, consisting of four steps: reading (Lectio), meditation (Meditatio), prayer (Oratio), and contemplation (Contemplatio). Each session is 15 minutes.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)

                    HStack {
                        Text("Scripture")
                        Spacer()
                        Text("Douay-Rheims Bible")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Notifications Denied", isPresented: $permissionDenied) {
                Button("OK") {}
            } message: {
                Text("Please enable notifications in Settings to receive daily reminders.")
            }
        }
    }
}
