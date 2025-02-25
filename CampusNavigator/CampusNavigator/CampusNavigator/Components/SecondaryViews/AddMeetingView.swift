import SwiftUI

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
