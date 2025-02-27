import SwiftUI

enum ImportanceLevel: String, CaseIterable {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

struct Announcement: Identifiable {
    let id = UUID()
    var title: String
    var details: String
    var date: Date
    var importance: ImportanceLevel
}

struct SpecialAnnouncementsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var announcements: [Announcement] = []
    @State var showAddScreen = false
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                VStack{
                    VStack{
                        // Header
                        HStack {
                            
                            
                            Text("Special Announcements").font(.title2).bold().foregroundColor(.white)
                                .padding()
                            
                            Spacer()
                            
                            Button(action: { self.showAddScreen = true }) {
                                Image(systemName: "megaphone.fill").font(.title2).foregroundColor(.white)
                            }.padding()
                            
                            
                        }
                        .shadow(radius: 2)
                        
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
                    .padding(.top,-20)
                }
                .background(Color.customDarkGreen)
              
                
                
                // List
                ScrollView {
                    Spacer()
                    VStack {
                        ForEach(announcements.filter {
                            searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) ||
                            $0.details.lowercased().contains(searchText.lowercased())
                        }) { announcement in
                            AnnouncementRow(announcement: announcement).padding(.horizontal)
                        }
                    }
                }
                BottomNavBar(selectedTab: "")
            }
            .sheet(isPresented: $showAddScreen) {
                AddAnnouncementView(announcements: $announcements, showSelf: $showAddScreen)
            }
            .background(Color(.systemGroupedBackground))
         
            
        }
        
        
    }
}


struct SpecialAnnouncementsView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialAnnouncementsView()
    }
}
