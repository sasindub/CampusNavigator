import SwiftUI

struct ResourceRow: View {
    let resource: ResourceItem

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: resource.icon)
                .font(.title2)
                .foregroundColor(.customDarkGreen)
                .frame(width: 40, height: 40)
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(resource.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                HStack {
                    Circle()
                        .fill(statusColor(for: resource.status))
                        .frame(width: 10, height: 10)
                    Text(resource.status.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text("Accuracy")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                ProgressView(value: resource.accuracy / 100.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: accuracyColor(for: resource.accuracy)))
                    .frame(width: 80)
            }

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }

    private func statusColor(for status: ResourceStatus) -> Color {
        switch status {
        case .available: return .green
        case .crowded: return .orange
        case .moderate: return .yellow
        case .closed: return .red
        }
    }

    private func accuracyColor(for accuracy: Double) -> Color {
        switch accuracy {
        case 90...100: return .green
        case 70..<90: return .yellow
        default: return .red
        }
    }
}

struct ResourceRow_Previews: PreviewProvider {
    static var previews: some View {
        ResourceStatusView()
    }
}
