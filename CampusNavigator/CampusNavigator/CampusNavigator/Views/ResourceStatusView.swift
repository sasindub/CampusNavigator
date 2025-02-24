import SwiftUI

enum ResourceStatus: String, CaseIterable {
    case available = "Available"
    case crowded = "Crowded"
    case moderate = "Moderate Crowded"
    case closed = "Closed"
}

struct ResourceStatusView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var searchText = ""
    @AppStorage("rewardPoints") private var rewardPoints = 0
    @State private var resources = [
        ResourceItem(title: "Library", icon: "book.fill", status: .available, accuracy: "78"),
        ResourceItem(title: "Cafeteria", icon: "fork.knife", status: .available, accuracy: "56"),
        ResourceItem(title: "Study Room", icon: "person.3.fill", status: .available, accuracy: "90"),
        ResourceItem(title: "Computer Lab", icon: "desktopcomputer", status: .available, accuracy: "100")
    ]
    
    var filteredResources: [ResourceItem] {
        searchText.isEmpty ? resources : resources.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationView {
            VStack {
                
              //header
                
                
                // Header
                VStack(spacing: 0) {
                    // Title Bar
                    HStack(alignment: .center) {
                        Text("Resource Status")
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
            .navigationBarHidden(true)
            
            
        }
        .navigationBarHidden(true)
        
        
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
    let accuracy: String
}

struct ResourceRow: View {
    let resource: ResourceItem
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: resource.icon)
                .font(.title2)
                .foregroundColor(Color.customDarkGreen)
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
            Text("Accuracy \(resource.accuracy)%")
                .font(.footnote)
                .foregroundColor(.white)
                .padding(2)
                .background(Color.red.opacity(0.7))
                .cornerRadius(4)
                
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

struct ResourceStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceStatusView()
    }
}
