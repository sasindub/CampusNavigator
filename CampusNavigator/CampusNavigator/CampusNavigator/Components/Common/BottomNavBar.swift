import SwiftUI

struct BottomNavBar: View {
    var selectedTab: String
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                BottomNavItem(icon: "house.fill", label: "Home", isActive: selectedTab == "home")
                BottomNavItem(icon: "magnifyingglass", label: "Search", isActive: selectedTab == "search")
                BottomNavItem(icon: "calendar", label: "Events", isActive: selectedTab == "events")
                BottomNavItem(icon: "person.fill", label: "Profile", isActive: selectedTab == "profile")
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 15)
            .padding(.bottom, 15)
            .background(Color.white)
            .shadow(radius: 2)
        }
    }
}
