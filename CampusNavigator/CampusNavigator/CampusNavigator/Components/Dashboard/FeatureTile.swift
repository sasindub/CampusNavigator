import SwiftUI

struct FeatureTile: View {
    let title: String
    let subtitle: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .font(.largeTitle.weight(.semibold))
                .symbolRenderingMode(.multicolor)
                .foregroundColor(title == "Navigator" ? .white : .customDarkGreen)
            
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundColor(title == "Navigator" ? .white : .customDarkGreen)
            
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(title == "Navigator" ? .white.opacity(0.8) : .customDarkGreen)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(title == "Navigator" ? Color.customDarkGreen : Color.green.opacity(0.1))
        )
        .shadow(color: .black.opacity(0.05 ), radius: 8, x: 0, y: 4)
    }
}
