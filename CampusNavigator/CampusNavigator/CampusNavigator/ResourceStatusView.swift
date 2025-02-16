import SwiftUI

enum ResourceStatus: String, CaseIterable {
    case available = "Available"
    case crowded = "Crowded"
    case moderate = "Moderate Crowded"
    case closed = "Closed"
}

struct ResourceStatusView: View {
    @State private var searchText = ""
    @AppStorage("rewardPoints") private var rewardPoints = 0
    @State private var resources = [
        ResourceItem(title: "Library", icon: "book.fill", status: .available),
        ResourceItem(title: "Cafeteria", icon: "fork.knife", status: .available),
        ResourceItem(title: "Study Room", icon: "person.3.fill", status: .available),
        ResourceItem(title: "Computer Lab", icon: "desktopcomputer", status: .available)
    ]
    
    var filteredResources: [ResourceItem] {
        searchText.isEmpty ? resources : resources.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    Text("Resource Status")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .background(Color.green)
                .shadow(radius: 2)

                // Search Bar
                TextField("Search...", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                // Resources List
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(filteredResources) { resource in
                            NavigationLink(
                                destination: ResourceDetailView(
                                    resource: $resources[getIndex(for: resource.id)],
                                    rewardPoints: $rewardPoints
                                )
                            ) {
                                ResourceRow(resource: resource)
                                    .padding(.horizontal)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.vertical, 10)
                }
                
                // Reward Points Section
                
                HStack {
                    Image(systemName: "bitcoinsign.circle.fill")
                        .foregroundColor(.yellow)
                        .font(.largeTitle)
                    Text("Your Rewards: \(rewardPoints) Points")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.black.opacity(0.6))
                .cornerRadius(12)
                .shadow(radius: 5)
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }
    }
    
    private func getIndex(for id: UUID) -> Int {
        guard let index = resources.firstIndex(where: { $0.id == id }) else {
            fatalError("Resource not found")
        }
        return index
    }
}

struct ResourceItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    var status: ResourceStatus
}

struct ResourceRow: View {
    let resource: ResourceItem
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: resource.icon)
                .font(.title2)
                .foregroundColor(.green)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(resource.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(resource.status.rawValue)
                    .font(.subheadline)
                    .foregroundColor(statusColor(for: resource.status))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
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
}

struct ResourceDetailView: View {
    @Binding var resource: ResourceItem
    @Binding var rewardPoints: Int
    @State private var previousStatus: ResourceStatus?
    
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
            
            Spacer()
        }
        .navigationTitle(resource.title)
        .onAppear {
            previousStatus = resource.status
        }
    }
}

struct ResourceStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceStatusView()
    }
}
