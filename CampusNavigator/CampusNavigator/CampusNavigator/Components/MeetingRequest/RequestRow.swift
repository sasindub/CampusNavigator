import SwiftUI

struct StaticRequestRow: View {
    var subject: String
    var lecturer: String
    var reason: String
    var date: String
    var status: String
    var statusColor: Color
    var reply: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
     
            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundColor(.green)
                Text(subject)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            
            Text("With: \(lecturer)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
         
            Text("Reason: \(reason)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
        
            Divider()
            
          
            HStack(alignment: .top) {
                if reply != "" {
                Image(systemName: "bubble.left.fill")
                        .foregroundColor(.customDarkGreen)
                VStack(alignment: .leading) {
                     Text("Reply:")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        Text(reply)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
                Spacer()
            }
   
            HStack {
                Text(date)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.customDarkGreen)
                    .cornerRadius(6)
                
                Spacer()
                
                Text(status)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(statusColor)
                    .cornerRadius(6)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}
