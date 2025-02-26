import SwiftUI



struct ProfileHeaderView: View {
    @AppStorage("rewardPoints") private var rewardPoints = 0
    var body: some View {
        ZStack {
            Color.customDarkGreen
                .ignoresSafeArea(edges: .top)
            
            HStack {
                Image("pro")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(.systemBackground), lineWidth: 1))
                    .foregroundColor(.white)
                
                VStack(alignment: .leading) {
                    Text("Welcome back,")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Text("Jone Doe")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                HStack(spacing: 8) {
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
                
                Button {
                    // Notification action
                } label: {
                    Image(systemName: "bell.badge.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.red, .white)
                        .font(.system(size: 20))
                }
            }
            .padding(.bottom, 20)
            .padding(.horizontal)
        }
        .frame(height: 70)
    }
}

