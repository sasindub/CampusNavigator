import SwiftUI


struct EventTile: View {
    let date: String
    let title: String
    let time: String
    
    var body: some View {
        HStack(spacing: 16) {
            VStack {
                Text(date)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(Color.customDarkGreen)
            }
            .padding(10)
            .frame(width: 60)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color.customDarkGreen, lineWidth: 1)
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(Color.customDarkGreen)
                
                Text(time)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
    }
}
