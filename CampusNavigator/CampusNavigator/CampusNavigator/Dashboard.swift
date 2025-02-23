import SwiftUI

extension Color {
    static let customDarkGreen = Color(red: 0/255, green: 55/255, blue: 6/255)
}

struct DashboardView: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 20) {
                    // Top Profile & Notification Bar
                    HStack {
                        Image("profile")
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
                            // Notification action
                        } label: {
                            Image(systemName: "bell.badge.fill")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.red, .white)
                                .font(.system(size: 20))
                        }
                    }
                    .padding()
                    .background(Color.customDarkGreen)
                    
                    // Feature Tiles
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible())], spacing: 16) {
                        FeatureTile(title: "Navigator", subtitle: "Find your way", icon: "map.fill")
                        FeatureTile(title: "Resources", subtitle: "Check availability", icon: "rectangle.portrait.and.arrow.right")
                    }
                    .padding(.horizontal)
                    
                    // Upcoming Events
                    SectionHeader(title: "Upcoming Events", action: "See all")
                        .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        EventTile(date: "24 MAR", title: "Tech Innovation Summit", time: "10:00 AM • Main Auditorium")
                            .padding(.top)
                            .padding(.horizontal)
                        EventTile(date: "24 MAR", title: "Tech Innovation Summit", time: "10:00 AM • Main Auditorium")
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                    .background(Color.white) // Added white background
                    .cornerRadius(12) // Ro
                    .padding(.horizontal)
                    
                    // Quick Links
                    SectionHeader(title: "Quick Links", action: "")
                        .padding(.horizontal)
                    
                    HStack(spacing: 24) {
                        QuickLink(icon: "plus.circle.fill", label: "Post Event")
                        QuickLink(icon: "person.2.fill", label: "Meet Lecturer")
                        QuickLink(icon: "lightbulb.fill", label: "Suggestions")
                    }
                    .padding(.horizontal)
                    
                    // Announcements
                    SectionHeader(title: "Announcements", action: "View all")
                        .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        AnnouncementTile(icon: "megaphone.fill", title: "Library Hours Extended", time: "2 hours ago")
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            
            // Bottom Navigation Bar
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

// MARK: - Components

struct SectionHeader: View {
    let title: String
    let action: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline.weight(.semibold))
            
            Spacer()
            
            if !action.isEmpty {
                Button(action: {}) {
                    Text(action)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct FeatureTile: View {
    let title: String
    let subtitle: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8
        ) {
            Image(systemName: icon)
                .font(.largeTitle.weight(.semibold))
                .symbolRenderingMode(.multicolor)
                .foregroundColor(title == "Navigator" ? .white : .customDarkGreen)
            
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundColor(title == "Navigator" ? .white : .customDarkGreen)
            
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(title == "Navigator" ? .white.opacity(0.8) : .customDarkGreen)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(title == "Navigator" ? Color.customDarkGreen : Color.green.opacity(0.1))
        )
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct EventTile: View {
    let date: String
    let title: String
    let time: String
    
    var body: some View {
        HStack(spacing: 16) {
            VStack {
                Text(date)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(Color.customDarkGreen)
            }
            .padding(10)
            .frame(width: 60)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color.customDarkGreen, lineWidth: 1)
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(Color.customDarkGreen)
                
                Text(time)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
    }
}

struct QuickLink: View {
    let icon: String
    let label: String
    
    var body: some View {
        Button {
            // Quick link action
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(Color.customDarkGreen)
                    
                
                Text(label)
                    .font(.caption)
                    .foregroundColor(.customDarkGreen)
                    .multilineTextAlignment(.center)
                    .fontWeight(.medium)
            }
            .frame(width: 105, height: 61)
            .font(.title3.weight(.semibold))
            .symbolRenderingMode(.monochrome)
            .foregroundColor(.green)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green.opacity(0.1))
            )
        }
    }
}

struct AnnouncementTile: View {
    let icon: String
    let title: String
    let time: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .symbolRenderingMode(.multicolor)
                .frame(width: 40)
                .foregroundColor(.orange)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.orange)
                
                Text(time)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.orange, lineWidth: 1)
        )
    }
}

struct BottomNavItem: View {
    let icon: String
    let label: String
    var isActive: Bool = false
    
    var body: some View {
        Button {
            // Navigation action
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .symbolVariant(isActive ? .fill : .none)
                    .font(.system(size: 20))
                
                Text(label)
                    .font(.caption2)
            }
            .foregroundColor(isActive ? .blue : .secondary)
            .frame(maxWidth: .infinity)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
