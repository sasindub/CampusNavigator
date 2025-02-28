import SwiftUI

struct EventsView: View {
    @AppStorage("rewardPoints") private var rewardPoints = 0
    @State var searchText = ""
    @State private var title = "Events"
    @State private var showAddScreen = false  // State to control when the AddEventView is shown
    
    var body: some View {
        VStack {
            // Header
            CommonHeader(rewardPoints: $rewardPoints, searchText: $searchText, title: $title)
                .padding(.top, -10)
            
            // Category
            HStack(spacing: 20) {
                Text("Upcoming")
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.green)
                    .cornerRadius(20)
                
                Text("Ongoing")
                    .foregroundColor(.gray)
                
                Text("Past")
                    .foregroundColor(.gray)
            }
            .padding(.top, 10)
            
            // Event Cards
            ScrollView {
                VStack(spacing: 20) {
                    EventCard(event: Event(title: "Fantastic Beast Movie Night", image: "event1", date: "31 January, 2025", time: "08:30 pm", location: "Campus Auditorium", description: "Join us for an unforgettable movie night featuring the magical world.", host: "Jennie", price: "LKR 750.00"))

                    EventCard(event: Event(title: "Halloween Party with Slim Shady Live", image: "event2", date: "08 February, 2025", time: "07:30 pm", location: "Campus Premises", description: "Get ready for a spooky night! Slim Shady performs live at our Halloween event.", host: "EMINEM", price: "LKR 1, 000.00"))

                    EventCard(event: Event(title: "Live Music Performance by Drake", image: "event3", date: "08 March, 2025", time: "09:00 pm", location: "Cinnamon lake", description: "Join us for a night of live music with Drake! Experience his hits live at the beautiful campus amphitheater.", host: "Drake", price: "LKR 5,000.00"))


                }
                .padding()
                .padding(.bottom, 75)
            }
            
            BottomNavBar(selectedTab: "events")
                .background(Color.white)
        }
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .overlay(
            // Floating Add Button
            FloatingAddButton(icon: "plus", showSheet: $showAddScreen)
                .padding(.horizontal)
                
                
        )
        .sheet(isPresented: $showAddScreen) {
            // Show AddEventView when the button is clicked
            AddEventView(showSelf: $showAddScreen)
        }
    }
}


struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
