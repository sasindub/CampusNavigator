import SwiftUI

struct ResourceStatusView: View {
    @State private var searchText = ""
    @State private var showLogoutAlert = false
    @State private var isLoggedOut = false // State to manage navigation

    let resources = [
        ResourceItem(title: "Library", icon: "book.fill", description: "Open: 8 AM - 10 PM", notifications: 2),
        ResourceItem(title: "Cafeteria", icon: "fork.knife", description: "Open: 7 AM - 8 PM", notifications: 1),
        ResourceItem(title: "Study Room", icon: "person.3.fill", description: "Available", notifications: 0),
        ResourceItem(title: "Computer Lab", icon: "desktopcomputer", description: "Open: 9 AM - 5 PM", notifications: 3)
    ]
    
    var filteredResources: [ResourceItem] {
        if searchText.isEmpty {
            return resources
        } else {
            return resources.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Header with Back Button
                HStack {
                    Button(action: {
                        // Action for back button
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                    .padding()

                    Text("Resource Status")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)

                    Spacer()
                }
                .padding(.vertical)
                .background(Color.green.opacity(0.2))
                .shadow(radius: 2)

                // Search Bar
                TextField("Search...", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                // Grid Layout
                ScrollView {
                    LazyVGrid(columns: [GridItem(.fixed(150)), GridItem(.fixed(150))], spacing: 16) {
                        ForEach(filteredResources) { resource in
                            NavigationLink(destination: ResourceDetailView(resource: resource)) {
                                ResourceTile(resource: resource)
                                    .frame(width: 150, height: 150) // Fixed width and height
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
            }
            .navigationBarHidden(true)
            .alert(isPresented: $showLogoutAlert) {
                Alert(
                    title: Text("Logout"),
                    message: Text("Are you sure you want to logout?"),
                    primaryButton: .destructive(Text("Yes")) {
                        isLoggedOut = true // Set the state to indicate logout
                    },
                    secondaryButton: .cancel()
                )
            }
            .background(
                NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), isActive: $isLoggedOut) {
                    EmptyView()
                }
            )
        }
    }
}

struct ResourceItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let description: String
    let notifications: Int
}

struct ResourceTile: View {
    let resource: ResourceItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: resource.icon)
                    .font(.title2)
                    .foregroundColor(.green)
                Spacer()
                
                // Notification Label
                if resource.notifications > 0 {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.white)
                        Text("\(resource.notifications)")
                    }
                    .background(Color.red)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(4)
                    .cornerRadius(8)
                }
            }
            
            Text(resource.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(resource.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// Dummy detail view for navigation
struct ResourceDetailView: View {
    let resource: ResourceItem
    
    var body: some View {
        VStack {
            Text(resource.title)
                .font(.largeTitle)
                .padding()
            Text(resource.description)
                .font(.body)
                .padding()
            Spacer()
        }
        .navigationTitle(resource.title)
    }
}



struct ResourceStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceStatusView()
    }
}
