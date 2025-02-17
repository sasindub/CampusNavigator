import SwiftUI

enum ImportanceLevel: String, CaseIterable {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

struct Announcement: Identifiable {
    let id = UUID()
    var title: String
    var details: String
    var date: Date
    var importance: ImportanceLevel
}

struct SpecialAnnouncementsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var announcements: [Announcement] = []
    @State var showAddScreen = false
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // Add this action
                    }) {
                        Image(systemName: "chevron.left").font(.title).foregroundColor(.white)
                    }.padding()
                    
                    Text("Special Announcements").font(.title2).bold().foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: { self.showAddScreen = true }) {
                        Image(systemName: "megaphone.fill").font(.title2).foregroundColor(.white)
                    }.padding()
                }
                .background(Color.green)
                .shadow(radius: 2)
                
                // Search
                TextField("Search announcements...", text: $searchText)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // List
                ScrollView {
                    Spacer()
                    VStack {
                        ForEach(announcements.filter {
                            searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) ||
                            $0.details.lowercased().contains(searchText.lowercased())
                        }) { announcement in
                            AnnouncementRow(announcement: announcement).padding(.horizontal)
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddScreen) {
                AddAnnouncementView(announcements: $announcements, showSelf: $showAddScreen)
            }
        }
        .navigationBarHidden(true)
    }
}

struct AnnouncementRow: View {
    var announcement: Announcement
    
    var importanceColor: Color {
        switch announcement.importance {
        case .high: return .red
        case .medium: return .orange
        case .low: return .green
        }
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(importanceColor)
                    Text(announcement.title).font(.headline)
                    Spacer()
                }
                
                Text(announcement.details)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .truncationMode(.tail)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 2)
            .padding(2)
            .background(
                RoundedRectangle(cornerRadius: 12)
                                  .fill(importanceColor)
                          )
           .padding(.horizontal, -1 )
            
            Text(dateString(from: announcement.date))
                .font(.caption)
                .foregroundColor(.white)
                .padding(6)
                .background(importanceColor)
                .cornerRadius(4)
                .padding(8)
        }
    }
    
    private func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

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

struct SpecialAnnouncementsView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialAnnouncementsView()
    }
}
