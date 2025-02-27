import SwiftUI

struct AddAnnouncementView: View {
    @Binding var announcements: [Announcement]
    @Binding var showSelf: Bool
    
    @State private var title = ""
    @State private var details = ""
    @State private var date = Date()
    @State private var selectedImportance: ImportanceLevel = .low
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Announcement Details")) {
                    TextField("Title", text: $title)
                    
                    DatePicker("Date & Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    
                    VStack(alignment: .leading) {
                        Text("Importance Level:")
                            .font(.subheadline)
                            .padding(.bottom, 4)
                        
                        ForEach(ImportanceLevel.allCases, id: \.self) { level in
                            HStack {
                                Image(systemName: selectedImportance == level ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(colorForLevel(level))
                                Text(level.rawValue)
                                    .foregroundColor(colorForLevel(level))
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedImportance = level
                            }
                        }
                    }
                    .padding(.vertical, 8)
                    
                    ZStack(alignment: .topLeading) {
                        if details.isEmpty {
                            Text("Announcement details")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                        }
                        TextEditor(text: $details)
                            .frame(minHeight: 150)
                    }
                }
            }
            
            HStack(spacing: 10) {
                Button("Cancel") {
                    showSelf = false
                }
                .frame(maxWidth: 150, minHeight: 40)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Add") {
                    announcements.append(Announcement(
                        title: title,
                        details: details,
                        date: date,
                        importance: selectedImportance
                    ))
                    showSelf = false
                }
                .frame(maxWidth: 150, minHeight: 40)
                .background(title.isEmpty ? Color.gray : Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(title.isEmpty)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.top)
        }
    }
    
    private func colorForLevel(_ level: ImportanceLevel) -> Color {
        switch level {
        case .high: return .red
        case .medium: return .orange
        case .low: return .green
        }
    }
}
