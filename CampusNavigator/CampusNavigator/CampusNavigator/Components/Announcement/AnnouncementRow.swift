
import SwiftUI

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
