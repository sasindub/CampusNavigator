import SwiftUI

struct ResourceDetailView: View {
    @Binding var resource: ResourceItem
    @Binding var rewardPoints: Int
    @State private var previousStatus: ResourceStatus?
    @State private var isConfirmed = false
    @State private var isSpaceRequested = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text(resource.title)
                .font(.largeTitle)
                .padding(.top)
            
            VStack(spacing: 15) {
                ForEach(ResourceStatus.allCases, id: \.self) { status in
                    HStack {
                        Image(systemName: resource.status == status ? "largecircle.fill.circle" : "circle")
                            .foregroundColor(resource.status == status ? .green : .gray)
                        Text(status.rawValue)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .onTapGesture {
                        if resource.status != status {
                            rewardPoints += 1
                        }
                        resource.status = status
                    }
                }
            }
            .padding(.horizontal)
            
            VStack(spacing: 15) {
                // Confirm Button
                Button(action: { isConfirmed = true
                    rewardPoints += 1}) {
                    Text(isConfirmed ? "Confirmed" : "Confirm")
                        .frame(maxWidth: 350, minHeight: 40)
                }
                .disabled(isConfirmed)
                .foregroundColor(.white)
                .background(isConfirmed ? Color.gray : .green)
                .cornerRadius(8)
                
                // Need a Space Button
                Button(action: { isSpaceRequested = true }) {
                    Text(isSpaceRequested ? "Space requested" : "Need a Space")
                        .frame(maxWidth: 350, minHeight: 40)
                }
                .disabled(isSpaceRequested)
                .foregroundColor(.white)
                .background(isSpaceRequested ? Color.gray : Color(white: 0.3))
                .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Resource Status")
        .onAppear { previousStatus = resource.status }
    }
}
