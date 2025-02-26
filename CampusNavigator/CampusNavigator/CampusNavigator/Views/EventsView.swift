    import SwiftUI



    struct EventsView: View {
        @AppStorage("rewardPoints") private var rewardPoints = 0
        @State var searchText = ""
        @State private var title = "Events"
        
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
                            EventCard(event: Event(title: "Blackpink Live Concert", image: "event1", members: "150k Members", spotsLeft: "8k Spots left", date: "31 January, 2023", time: "08:30 pm", host: "Jennie", price: "$350.00"))
                            
                            EventCard(event: Event(title: "Slim Shady Performing Live", image: "event2", members: "250k Members", spotsLeft: "12k Spots left", date: "08 February, 2023", time: "07:30 pm", host: "EMINEM", price: "$500.00"))
                            
                            EventCard(event: Event(title: "Drake Performing Live at Ontario", image: "event3", members: "200k Members", spotsLeft: "6k Spots left", date: "08 March, 2023", time: "09:00 pm", host: "Drake", price: "$400.00"))
                        }
                        .padding()
                    }
                    
                    BottomNavBar(selectedTab: "events")
                                   .background(Color.white)
               
                                  
                }
                .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            
             
        }
        
        
    }


    struct EventsView_Previews: PreviewProvider {
        static var previews: some View {
            EventsView()
        }
    }
