import SwiftUI

struct BottomNavItem: View {
    let icon: String
    let label: String
    var isActive: Bool = false
    
    var body: some View {
        Button {
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .symbolVariant(isActive ? .fill : .none)
                    .font(.system(size: 20))
                
                Text(label)
                    .font(.caption2)
            }
            .foregroundColor(isActive ? .blue : .secondary)
            .frame(maxWidth: .infinity)
        }
    }
}
