import SwiftUI

struct SectionHeader: View {
    let title: String
    let action: String
    let destination: AnyView?
    
    init<V: View>(title: String, action: String, destination: V? = nil) {
        self.title = title
        self.action = action
        self.destination = destination != nil ? AnyView(destination) : nil
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline.weight(.semibold))
            
            Spacer()
            
            if !action.isEmpty, let destination = destination {
                NavigationLink(destination: destination) {
                    Text(action)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.blue)
                }
            } else if !action.isEmpty {
                Text(action)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.blue)
            }
        }
        .padding() // Add some padding for better appearance
    }
}


