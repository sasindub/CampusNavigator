import SwiftUI

struct DashboardView: View {
    @State private var showLogoutAlert = false
    @State private var isLoggedOut = false // State to manage navigation

    let features = [
        FeatureItem(title: "Text Navigation", icon: "map", description: "Find your way around campus", color: .green, notifications: 3),
        FeatureItem(title: "Resource Status", icon: "chart.bar", description: "Check real-time availability", color: .green, notifications: 1),
        FeatureItem(title: "Campus Events", icon: "calendar", description: "View & post activities", color: .green, notifications: 5),
        FeatureItem(title: "Meet Lecturers", icon: "person.fill", description: "Request a meeting", color: .green, notifications: 0),
        FeatureItem(title: "Announcements", icon: "megaphone", description: "Important updates", color: .green, notifications: 2),
        FeatureItem(title: "Feedback", icon: "text.bubble", description: "Submit suggestions", color: .green, notifications: 4)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Gradient Background
                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.3), Color.white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Spacer() // This spacer pushes the title to the center

                        Text("Campus Navigator")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)

                        Spacer() // This spacer helps in centering the title
                    }
                    .padding(.vertical)
                    .background(Color.green)
                    .shadow(radius: 2)
                    
                    // Add margin between header and welcome message
                    Spacer(minLength: 40) // Adjust the value as needed
                    
                    // Welcome Message with Logout Button
                    HStack {
                        Button(action: {
                            showLogoutAlert = true // Show the logout confirmation alert
                        }) {
                            HStack {
                                Image(systemName: "arrow.right.square") // Logout icon
                                    .foregroundColor(.white)
                                Text("Logout")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .padding(8)
                            .background(Color.green)
                            .cornerRadius(8)
                        }
                        .padding(.trailing) // Add some space to the right of the button
                        
                        Spacer()
                        
                        Image(systemName: "person.fill")
                            .font(.title2)
                            .foregroundColor(.green)
                        Text("Welcome, User!")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    
                    Spacer(minLength: 30)
                    
                    // Feature Grid
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(features) { feature in
                                NavigationLink(destination: FeatureDetailView(feature: feature)) {
                                    FeatureTile(feature: feature)
                                    
                                }
                            }
                        }
                        .padding(.horizontal) // Add horizontal padding for safe area
                        .padding(.top, 10)
                    }
                    
                    HStack {
                        Image(systemName: "bitcoinsign.circle.fill")
                            .foregroundColor(.yellow)
                            .font(.largeTitle)
                        Text("Your Redeems: 120 Points")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding(.horizontal)

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


// The rest of your code remains unchanged...

struct FeatureItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let description: String
    let color: Color
    let notifications: Int // Add notifications property
}

struct FeatureTile: View {
    let feature: FeatureItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: feature.icon)
                    .font(.title2)
                    .foregroundColor(feature.color)
                Spacer()
                
                // Notification Label
                if feature.notifications > 0 {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.white)
                        Text("\(feature.notifications)")
                    }
                    .background(Color.red)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color.red)
                    .cornerRadius(8)
                }
            }
            
            Text(feature.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(feature.description)
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
struct FeatureDetailView: View {
    let feature: FeatureItem
    
    var body: some View {
        VStack {
            Text(feature.title)
                .font(.largeTitle)
                .padding()
            Text(feature.description)
                .font(.body)
                .padding()
            Spacer()
        }
        .navigationTitle(feature.title)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
