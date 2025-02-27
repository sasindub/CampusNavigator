import SwiftUI

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
