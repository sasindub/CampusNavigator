import SwiftUI

struct ComplaintSuggestion: Identifiable {
    let id = UUID()
    var subject: String
    var details: String
    var date: Date
    var isSuggestion: Bool
}

struct ComplaintsView: View {
    @State var entries: [ComplaintSuggestion] = []
    @State var showAddScreen = false
    @State var searchText = ""
    @State var itemToDelete: ComplaintSuggestion?
    
    var filteredEntries: [ComplaintSuggestion] {
        searchText.isEmpty ? entries : entries.filter {
            $0.subject.lowercased().contains(searchText.lowercased()) ||
            $0.details.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left").font(.title).foregroundColor(.white)
                    }.padding()
                    
                    Text("Complaints & Suggestions").font(.title2).bold().foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: { self.showAddScreen = true }) {
                        Image(systemName: "plus").font(.title2).foregroundColor(.white)
                    }.padding()
                }
                .background(Color.green)
                .shadow(radius: 2)
                
                // Search
                TextField("Search entries...", text: $searchText)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // List
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(filteredEntries) { entry in
                            ComplaintRow(entry: entry, onDelete: {
                                itemToDelete = entry
                            })
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .sheet(isPresented: $showAddScreen) {
                AddComplaintView(entries: $entries, showSelf: $showAddScreen)
            }
            .alert(item: $itemToDelete) { item in
                Alert(
                    title: Text("Delete Entry"),
                    message: Text("Are you sure you want to delete this entry?"),
                    primaryButton: .destructive(Text("Delete")) {
                        entries.removeAll { $0.id == item.id }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationBarHidden(true)
    }
}

struct ComplaintRow: View {
    var entry: ComplaintSuggestion
    var onDelete: () -> Void
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: entry.isSuggestion ? "lightbulb.fill" : "exclamationmark.triangle.fill")
                        .foregroundColor(entry.isSuggestion ? .green : .red)
                    
                    Text(entry.subject)
                        .font(.headline)
                    
                    Spacer()
                }
                
                Text(entry.details)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .truncationMode(.tail)
                
                HStack {
                    Text(dateFormatter.string(from: entry.date))
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button(action: onDelete) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
                .padding(.top, 4)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 2)
        }
    }
}

struct AddComplaintView: View {
    @Binding var entries: [ComplaintSuggestion]
    @Binding var showSelf: Bool
    
    @State private var subject = ""
    @State private var details = ""
    @State private var isSuggestion = false
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Entry Details")) {
                    TextField("Subject", text: $subject)
                    
                    Toggle("Is Suggestion", isOn: $isSuggestion)
                        .toggleStyle(SwitchToggleStyle(tint: .green))
                    
                    ZStack(alignment: .topLeading) {
                        if details.isEmpty {
                            Text("Details")
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
                    entries.append(ComplaintSuggestion(
                        subject: subject,
                        details: details,
                        date: Date(),
                        isSuggestion: isSuggestion
                    ))
                    showSelf = false
                }
                .frame(maxWidth: 150, minHeight: 40)
                .background(subject.isEmpty ? Color.gray : Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(subject.isEmpty)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.top)
        }
    }
}

struct ComplaintsView_Previews: PreviewProvider {
    static var previews: some View {
        ComplaintsView()
    }
}
