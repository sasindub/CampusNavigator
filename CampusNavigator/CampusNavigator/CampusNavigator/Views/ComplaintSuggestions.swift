import SwiftUI

struct ComplaintsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var entries: [ComplaintSuggestion] = []
    @State var showAddScreen = false
    @State var searchText = ""
    @State var itemToDelete: ComplaintSuggestion?
    
    var filteredEntries: [ComplaintSuggestion] {
        searchText.isEmpty ? entries : entries.filter {
            $0.subject.lowercased().contains(searchText.lowercased()) ||
            $0.details.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                VStack{
                    VStack{
                        // Header
                        HStack {
                            Text("Complaints & Suggestions").font(.title2).bold().foregroundColor(.white)
                                .padding()
                            
                            Spacer()
                            
                            Button(action: { self.showAddScreen = true }) {
                                Image(systemName: "plus").font(.title2).foregroundColor(.white)
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
                    VStack(spacing: 12) {
                        ForEach(filteredEntries) { entry in
                            ComplaintRow(entry: entry, onDelete: {
                                itemToDelete = entry
                            })
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 10)
                }
                
                BottomNavBar(selectedTab: "")
            }
            .sheet(isPresented: $showAddScreen) {
                AddComplaintView(entries: $entries, showSelf: $showAddScreen)
            }
            .alert(item: $itemToDelete) { item in
                Alert(
                    title: Text("Delete Entry"),
                    message: Text("Are you sure you want to delete this entry?"),
                    primaryButton: .destructive(Text("Delete")) {
                        entries.removeAll { $0.id == item.id }
                    },
                    secondaryButton: .cancel()
                )
            }
            .background(Color(.systemGroupedBackground))
        }
        .navigationBarHidden(true)
        
    }
}





struct ComplaintsView_Previews: PreviewProvider {
    static var previews: some View {
        ComplaintsView()
    }
}
