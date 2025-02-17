import SwiftUI

struct EventItem: Identifiable {
    let id = UUID()
    var title: String
    var link: String
    var description: String
    var icon: String
    var date: Date
    var venue: String
}

struct EventsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var events: [EventItem] = []
    @State var showAddScreen = false
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Button( action: {
                        presentationMode.wrappedValue.dismiss() // Add this action
                    }) {
                        Image(systemName: "chevron.left").font(.title).foregroundColor(.white)
                    }.padding()
                    
                    Text("Events & Activities").font(.title2).bold().foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: { self.showAddScreen = true }) {
                        Image(systemName: "plus").font(.title2).foregroundColor(.white)
                    }.padding()
                }
                .background(Color.green)
                .shadow(radius: 2)
                
                // Search
                TextField("Search events...", text: $searchText)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .contentMargins(50)
           
                // List
                ScrollView {
                    Spacer()
                    VStack {
                        ForEach(events.filter {
                            searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased())
                        }) { event in
                            EventRow(event: event).padding(.horizontal)
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddScreen) {
                AddEventView(events: $events, showSelf: $showAddScreen)
            }
        }
        .navigationBarHidden(true)
    }
}

struct EventRow: View {
    var event: EventItem
    @State var dateString = ""
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: event.icon)
                        .foregroundColor(.green)
                        .font(.title2)
                    Text(event.title)
                        .font(.headline)
                    Spacer()
                }
                
                Text(event.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 4)
                
                HStack{
                    if event.link != "" {
                        Link("More Details", destination: URL(string: event.link)!)
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    Text("Attend")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 4)
                    
                }
                
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 2)
            
            VStack(alignment: .trailing, spacing: 8) {
                // Date
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                    Text(getDateString(date: event.date))
                }
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.green.opacity(0.9))
                .cornerRadius(4)
                .padding([.top, .trailing], 8)
                
                
                // Venue
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .symbolRenderingMode(.hierarchical)
                    Text(event.venue)
                }
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                        startPoint: .leading, endPoint: .trailing))
                .cornerRadius(4)
                .padding([.bottom, .trailing], 8)
            }
        }
    }
    
    func getDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct AddEventView: View {
    @Binding var events: [EventItem]
    @Binding var showSelf: Bool
    @State var title = ""
    @State var link = ""
    @State var desc = ""
    @State var pickedIcon = "calendar"
    @State var date = Date()
    @State var venue = ""
    
    let icons = ["calendar", "person.fill", "book.fill", "gamecontroller.fill", "graduationcap.fill", "music.note"]
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $title)
                    
                    HStack {
                        Text("Icon")
                        Spacer()
                        Menu {
                            ForEach(icons, id: \.self) { icon in
                                Button(action: { pickedIcon = icon }) {
                                    HStack {
                                        Image(systemName: icon)
                                        Text(icon)
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Image(systemName: pickedIcon)
                                Text(pickedIcon)
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Venue", text: $venue)
                    
                    HStack {
                        TextField("URL", text: $link)
                        Button(action: {
                            link = UIPasteboard.general.string ?? ""
                        }) {
                            Image(systemName: "doc.on.clipboard").foregroundColor(.blue)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Description:")
                            .foregroundColor(desc.isEmpty ? .gray : .clear)
                        TextEditor(text: $desc)
                            .frame(minHeight: 100)
                    }
                }
            }
            
            HStack(spacing:10) {
                Button("Cancel") {
                    showSelf = false
                }
                .frame(maxWidth: 150, minHeight: 40)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Add") {
                    events.append(EventItem(
                        title: title,
                        link: link,
                        description: desc,
                        icon: pickedIcon,
                        date: date,
                        venue:venue
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
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
