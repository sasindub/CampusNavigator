import SwiftUI

enum RequestStatus: String, CaseIterable {
    case pending = "Pending"
    case approved = "Approved"
    case rejected = "Rejected"
    case rescheduled = "Rescheduled"
}

struct MeetingRequest: Identifiable {
    let id = UUID()
    var date: Date
    var lecturer: String
    var subject: String
    var reason: String
    var status: RequestStatus
}

struct RequestMeetingView: View {
    @State var requests: [MeetingRequest] = []
    @State var showAddScreen = false
    @State var searchText = ""
    
    let lecturers = ["Dr. Smith", "Prof. Johnson", "Dr. Wilson", "Prof. Davis"]
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left").font(.title).foregroundColor(.white)
                    }.padding()
                    
                    Text("Meeting Requests").font(.title2).bold().foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: { self.showAddScreen = true }) {
                        Image(systemName: "person.badge.plus").font(.title2).foregroundColor(.white)
                    }.padding()
                }
                .background(Color.green)
                .shadow(radius: 2)
                
                // Search
                TextField("Search requests...", text: $searchText)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // List
                ScrollView {
                    Spacer()
                    VStack {
                        ForEach(requests.filter {
                            searchText.isEmpty ? true : $0.subject.lowercased().contains(searchText.lowercased())
                        }) { request in
                            RequestRow(request: request).padding(.horizontal)
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddScreen) {
                AddMeetingView(requests: $requests, showSelf: $showAddScreen, lecturers: lecturers)
            }
        }
        .navigationBarHidden(true)
    }
}

struct RequestRow: View {
    var request: MeetingRequest
    @State var dateString = ""
    
    var statusColor: Color {
        switch request.status {
        case .pending: return .orange
        case .approved: return .green
        case .rejected: return .red
        case .rescheduled: return .green
        }
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.3.fill").foregroundColor(.green)
                    Text(request.subject).font(.headline)
                    Spacer()
                }
                
                Text("With: \(request.lecturer)").font(.subheadline).foregroundColor(.gray)
                Text("Reason: \(String(request.reason.prefix(50)))\(request.reason.count > 60 ? "..." : "")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 2)
            
            VStack(alignment: .trailing) {
                Text(getDateString(date: request.date))
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.green)
                    .cornerRadius(4)
                
                Text(request.status.rawValue)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(statusColor)
                    .cornerRadius(4)
            }
            .padding(8)
        }
        
    }
    
    func getDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct AddMeetingView: View {
    @Binding var requests: [MeetingRequest]
    @Binding var showSelf: Bool
    let lecturers: [String]
    
    @State var selectedLecturer = ""
    @State var date = Date()
    @State var subject = ""
    @State var reason = ""
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Meeting Details")) {
                    DatePicker("Date & Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    
                    HStack {
                        Text("Lecturer")
                        Spacer()
                        Menu {
                            ForEach(lecturers, id: \.self) { lecturer in
                                Button(action: { selectedLecturer = lecturer }) {
                                    Text(lecturer)
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedLecturer.isEmpty ? "Select Lecturer" : selectedLecturer)
                                Image(systemName: "chevron.down")
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                    
                    TextField("Subject", text: $subject)
                    
                    ZStack(alignment: .topLeading) {
                        if reason.isEmpty {
                            Text("Reason")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                        }
                        TextEditor(text: $reason)
                            .frame(minHeight: 100)
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
                
                Button("Submit") {
                    requests.append(MeetingRequest(
                        date: date,
                        lecturer: selectedLecturer,
                        subject: subject,
                        reason: reason,
                        status: .pending
                    ))
                    showSelf = false
                }
                .frame(maxWidth: 150, minHeight: 40)
                .background(subject.isEmpty || selectedLecturer.isEmpty ? Color.gray : Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(subject.isEmpty || selectedLecturer.isEmpty)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.top)
        }
    }
}

struct RequestMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        RequestMeetingView()
    }
}
