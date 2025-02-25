import SwiftUI

struct RequestMeetingView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var requests: [MeetingRequest] = []
    @State var showAddScreen = false
    @State var searchText = ""
    @State private var title = "Meeting Request"
    @AppStorage("rewardPoints") private var rewardPoints = 0
    
    let lecturers = ["Dr. Thisara", "Prof. Johnson", "Dr. Wilson", "Prof. David"]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Header
                    CommonHeader(rewardPoints: $rewardPoints, searchText: $searchText, title: $title)
                        .padding(.top, -10)
                    
                  
                    
                    // Static Meeting Requests
                    ScrollView {
                        Spacer()
                        VStack(spacing: 10) {
                            StaticRequestRow(
                                subject: "Research Discussion",
                                lecturer: "Dr. Thisara",
                                reason: "Discuss research methodology and findings.",
                                date: "Feb 25, 2025 - 3:00 PM",
                                status: "Approved",
                                statusColor: .green,
                                reply: "Please bring research document when you come."
                            )
                            

                            StaticRequestRow(
                                subject: "Assignment Help",
                                lecturer: "Prof. Johnson",
                                reason: "Need guidance on assignment topic selection.",
                                date: "Feb 27, 2025 - 10:00 AM",
                                status: "Pending",
                                statusColor: .orange,
                                reply: ""
                            )
                            
                            StaticRequestRow(
                                subject: "Assignment Help",
                                lecturer: "Prof. Johnson",
                                reason: "Need guidance on assignment topic selection.",
                                date: "Feb 27, 2025 - 10:00 AM",
                                status: "Rejected",
                                statusColor: .red,
                                reply: "Lecturer will be busy that day, please come on 1st of October 2025."
                            )


                        }
                        .padding(.bottom, 85)
                    }
                    
                    
                    Spacer()
                    
                    BottomNavBar(selectedTab: "search")
                }
                
                // Floating Add Button
                FloatingAddButton(icon: "plus", showSheet: $showAddScreen)
            }
            .sheet(isPresented: $showAddScreen) {
                AddMeetingView(requests: $requests, showSelf: $showAddScreen, lecturers: lecturers)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RequestMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        RequestMeetingView()
    }
}
