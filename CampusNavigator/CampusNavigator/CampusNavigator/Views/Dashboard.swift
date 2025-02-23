import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack {
                    Color.customDarkGreen
                        .ignoresSafeArea(edges: .top)
                    HStack {
                        Image("person.crop.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(.systemBackground), lineWidth: 1))
                        
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
                            
                            Text("78")
                                .fontWeight(.medium)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(.green.opacity(0.9))
                        .clipShape(Capsule())
                        
                        Button {
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
                
                Spacer()
                Spacer()
                
                ScrollView {
                    VStack(spacing: 20) {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible())], spacing: 16) {
                            NavigationLink(destination: NavigatorView()) {
                                FeatureTile(title: "Navigator", subtitle: "Find your way", icon: "map.fill")
                            }
                            NavigationLink(destination: ResourceStatusView()) {
                                FeatureTile(title: "Resources", subtitle: "Check availability", icon: "rectangle.portrait.and.arrow.right")
                            }
                        }
                        .padding(.horizontal)
                        
                        SectionHeader(title: "Upcoming Events", action: "See all", destination: EventsView())
                            .padding(.horizontal)
                        
                        VStack(spacing: 16) {
                            EventTile(date: "24 MAR", title: "Tech Innovation Summit", time: "10:00 AM • Main Auditorium")
                                .padding(.top)
                                .padding(.horizontal)
                            EventTile(date: "24 MAR", title: "Tech Innovation Summit", time: "10:00 AM • Main Auditorium")
                                .padding(.horizontal)
                                .padding(.bottom)
                        }
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                   
                        SectionHeader(title: "Quick Links", action: "", destination: EventsView())
                            .padding(.horizontal)
                        
                        HStack(spacing: 24) {
                            NavigationLink(destination: EventsView()) {
                                QuickLink(icon: "plus.circle.fill", label: "Post Event")
                            }
                            NavigationLink(destination: RequestMeetingView()) {
                                QuickLink(icon: "person.2.fill", label: "Meet Lecturer")
                            }
                            NavigationLink(destination: ComplaintsView()) {
                                QuickLink(icon: "lightbulb.fill", label: "Suggestions")
                            }
                        }
                        .padding(.horizontal)
                        
                        SectionHeader(title: "Announcements", action: "View all", destination: SpecialAnnouncementsView())
                            .padding(.horizontal)
                        
                        VStack(spacing: 16) {
                            AnnouncementTile(icon: "megaphone.fill", title: "Library Hours Extended", time: "2 hours ago")
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
                
                VStack(spacing: 0) {
                    Divider()
                    HStack {
                        BottomNavItem(icon: "house.fill", label: "Home", isActive: true)
                        BottomNavItem(icon: "magnifyingglass", label: "Search")
                        BottomNavItem(icon: "calendar", label: "Events")
                        BottomNavItem(icon: "person.fill", label: "Profile")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
                    .background(.regularMaterial)
                }
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

// MARK: - Supporting Views


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

struct NavigatorView: View {
    var body: some View {
        Text("Navigator View")
    }
}



