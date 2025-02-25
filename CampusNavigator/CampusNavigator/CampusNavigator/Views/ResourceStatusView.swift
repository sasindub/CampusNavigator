import SwiftUI

struct ResourceStatusView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var searchText = ""
    @State private var title = "Resource Status" 
    @AppStorage("rewardPoints") private var rewardPoints = 0
    @State private var resources = [
        ResourceItem(title: "Library", icon: "book.fill", status: .available, accuracy: 78),
        ResourceItem(title: "Cafeteria", icon: "fork.knife", status: .available, accuracy: 56),
        ResourceItem(title: "Study Room", icon: "person.3.fill", status: .available, accuracy: 90),
        ResourceItem(title: "Computer Lab", icon: "desktopcomputer", status: .available, accuracy: 100)
    ]
    
    var filteredResources: [ResourceItem] {
        searchText.isEmpty ? resources : resources.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        VStack {
            // Search and points header
            CommonHeader(rewardPoints: $rewardPoints, searchText: $searchText, title: $title)
            
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
            
            // Bottom navigation
            VStack(spacing: 0) {
                Divider()
                HStack {
                    BottomNavItem(icon: "house.fill", label: "Home")
                    BottomNavItem(icon: "magnifyingglass", label: "Search", isActive: true)
                    BottomNavItem(icon: "calendar", label: "Events")
                    BottomNavItem(icon: "person.fill", label: "Profile")
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 15)
                .background(.white)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)


    }
    
    private func getIndex(for id: UUID) -> Int {
        guard let index = resources.firstIndex(where: { $0.id == id }) else {
            fatalError("Resource not found")
        }
        return index
    }
}

struct ResourceStatusView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResourceStatusView()
        }
    }
}
