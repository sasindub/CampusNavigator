import SwiftUI

struct QuickLink: View {
    let icon: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(Color.customDarkGreen)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.customDarkGreen)
                .multilineTextAlignment(.center)
                .fontWeight(.medium)
        }
        .frame(width: 105, height: 61)
        .font(.title3.weight(.semibold))
        .symbolRenderingMode(.monochrome)
        .foregroundColor(.green)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.green.opacity(0.1))
        )
    }
}

