import SwiftUI

struct ResourceStatusHeader: View {
    @Binding var rewardPoints: Int
    @Binding var searchText: String
    @Binding var title: String

    var body: some View {
        VStack(spacing: 0) {
            // Title Bar
            HStack(alignment: .center) {
                Text("\(title)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)

                HStack(spacing: 6) {
                    Image(systemName: "star.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .green)

                    Text("\(rewardPoints)")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.green.opacity(0.9))
                .clipShape(Capsule())
                .padding(.trailing)

                Button {
                    // Notification action
                } label: {
                    Image(systemName: "bell.badge.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.red, .white)
                        .font(.system(size: 20))
                }
                .padding([.trailing, .vertical])
                .padding(.leading, -10)
            }
            .frame(height: 44)
            .padding(.top, 1)
            .padding(.bottom)

            // Search Bar
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)

                    TextField("Search", text: $searchText)
                        .padding(.vertical, 8)
                        .padding(.trailing, 8)
                }
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color.customDarkGreen)
    }
}
