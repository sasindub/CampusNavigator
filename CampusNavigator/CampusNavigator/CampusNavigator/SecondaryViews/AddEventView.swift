import SwiftUI

struct AddEventView: View {
    @Binding var showSelf: Bool
    
    // For Event
    @State private var title = ""
    @State private var link = ""
    @State private var desc = ""
    @State private var pickedImage: Image? = nil
    @State private var imageData: Data? = nil
    @State private var date = Date()
    @State private var time = Date()
    @State private var venue = ""
    @State private var isEvent = true
    @State private var price = ""
    
    var body: some View {
        VStack {
            Form {
                // Event Details Section
                Section(header: Text("Event Details")) {
                    
                    TextField("Title", text: $title)
                    
                    // Image upload part for Event
                    VStack {
                        Text("Upload Event Image")
                            .font(.headline)
    
                        Button(action: {
                            selectImage()
                        }) {
                            VStack {
                                if let pickedImage = pickedImage {
                                    pickedImage
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                } else {
                                    Image(systemName: "photo")
                                        .font(.system(size: 50))
                                        .foregroundColor(.gray)
                                        .frame(width: 100, height: 100)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
    
                    // Date & Time Picker
                    DatePicker("Date & Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    
                    TextField("Venue", text: $venue)
    
                    TextField("Price (1,000 LKR)", text: $price)
                                     
    
                    VStack(alignment: .leading) {
                        Spacer()
                        Text("Description:")
                            .foregroundColor(desc.isEmpty ? .gray : .clear)
                        TextEditor(text: $desc)
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
                
                Button("Add Event") {
                    // Add your logic to add an event
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
        .onAppear {
            // Keeping the flag for event to be true
            isEvent = true
        }
    }
    
    // Method to select an image
    func selectImage() {
        // You can add your image picker logic here
        // For now, we are simulating an image selection
        if let image = UIImage(named: "sample-image") {
            pickedImage = Image(uiImage: image)
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(showSelf: .constant(true))
    }
}
