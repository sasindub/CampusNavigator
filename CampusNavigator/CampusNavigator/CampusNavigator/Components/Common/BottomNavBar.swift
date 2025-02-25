import SwiftUI

struct BottomNavBar: View {
    var selectedTab: String
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                BottomNavItem(icon: "house.fill", label: "Home", isActive: selectedTab == "home")
                BottomNavItem(icon: "rectangle.portrait.and.arrow.right.fill", label: "status", isActive: selectedTab == "status")
                BottomNavItem(icon: "map.fill", label: "navigator", isActive: selectedTab == "navigator")
                BottomNavItem(icon: "person.2.fill", label: "meets", isActive: selectedTab == "meets")
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 15)
            .background(.white)
        }
    }
}
