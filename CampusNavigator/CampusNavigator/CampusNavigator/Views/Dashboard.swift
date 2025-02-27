import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ProfileHeaderView()
                
                
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
                        .padding(.bottom, -20)
                        
                        SectionHeader(title: "Upcoming Events", action: "See all", destination: EventsView())
                            .padding(.horizontal)
                            .padding(.bottom, -20)
                        
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
                        .padding(.bottom, -20)
                        
                   
                        SectionHeader(title: "Quick Links", action: "", destination: EventsView())
                            .padding(.horizontal)
                            .padding(.bottom, -20)
                        
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
                        .padding(.bottom, -20)
                        
                        SectionHeader(title: "Announcements", action: "View all", destination: SpecialAnnouncementsView())
                            .padding(.horizontal)
                            .padding(.bottom, -20)
                        
                        VStack(spacing: 16) {
                            AnnouncementTile(icon: "megaphone.fill", title: "Library Hours Extended", time: "2 hours ago")
                        }
                        .padding(.horizontal,23)
                        .padding(.bottom)
                    }
                }
                
                // Bottom navigation
                BottomNavBar(selectedTab: "home")
            }
            .background(Color(.systemGroupedBackground))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}




struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}





