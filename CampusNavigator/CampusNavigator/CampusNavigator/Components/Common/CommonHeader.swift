/*import SwiftUI

struct HeaderView: View {
    var title: String
    var rewardPoints: Int
    
    
    var body: some View {
        VStack(spacing: 0) {
            // Title Bar
            HStack(alignment: .center) {
                Text(title)
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
                
                Button(action: {}) {
                    Image(systemName: "bell.badge.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.red, .white)
                        .font(.system(size: 20))
                }
                .padding(.trailing)
            }
            .frame(height: 44)
            .padding(.top, 1)
            .padding(.bottom)
            
            // Search Bar
            SearchBar()
        }
        .background(Color.customDarkGreen)
    }
}

*/
