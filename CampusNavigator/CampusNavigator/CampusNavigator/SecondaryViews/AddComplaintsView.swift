import SwiftUI

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
