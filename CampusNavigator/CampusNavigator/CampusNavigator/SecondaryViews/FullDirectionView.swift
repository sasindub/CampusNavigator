import SwiftUI

struct FullDirectionsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Estimated Time")) {
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)
                        Text("~5 minutes")
                        Spacer()
                    }
                }
                
                Section(header: Text("Transit Options")) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                        Text("Elevator available")
                        Spacer()
                    }
                }
                
                Section(header: Text("Navigation Steps")) {
                    NavigationStepView(icon: "door.left.hand.open", step: "Exit the Library and head toward the north-side elevator.", time: "1 min")
                    NavigationStepView(icon: "arrow.down.to.line", step: "Take the elevator down from the 3rd floor to the Ground Floor.", time: "1 min")
                    NavigationStepView(icon: "signpost.right", step: "Follow signage toward Main Gate 1, then turn right.", time: "2 min")
                    NavigationStepView(icon: "fork.knife", step: "Find the Cafeteria adjacent to the gate.", time: "1 min")
                    
                    // Button Section
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                               
                            }) {
                                Text("Got the place")
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 3)
                                    .background(Color.green)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Text("Stranded")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 35)
                                    .padding(.vertical, 3)
                                    .background(Color.red)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                            Spacer()
                        }
                        
                        Text("Get stuck on somewhere?")
                            .foregroundColor(.gray)
                            .fontWeight(.medium)
                            .font(.callout)
                            .padding(.trailing,100)
                            .padding(.top, 5)
                            
                        
                        Text("If you are stuck on somewhere, just change where you now and where you want to go, then again search for the direction from the stuck place.")
                            .foregroundColor(.gray)
                            .fontWeight(.medium)
                            .font(.caption)
                            .padding(.horizontal)
                    }
                    .padding(.top, 5)
                    
                }
                
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Directions to Destination")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    
                }
            }
            .listSectionSpacing(0)
        }
    }
}


struct FullDirectionsView_Previews: PreviewProvider {
    static var previews: some View {
        FullDirectionsView()
    }
}
