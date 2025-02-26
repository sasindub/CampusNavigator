import SwiftUI

struct CollapsedDirectionsPanel: View {
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .frame(width: 40, height: 5)
                .foregroundColor(.gray)
                .padding(.top, 8)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Estimated time: 5 min")
                        .font(.subheadline)
                        .foregroundColor(.customDarkGreen)
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Elevator available")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button("Show More") {
                    isExpanded = true
                }
                .foregroundColor(.customDarkGreen)
                .padding(.horizontal)
            }
            .padding()
            
            Divider()
            
            ScrollView {
                VStack(alignment: .leading) {
                    NavigationStepView(icon: "door.left.hand.open", step: "Exit the Library and head toward the north-side elevator.", time: "1 min")
                    NavigationStepView(icon: "arrow.down.to.line", step: "Take the elevator down from the 3rd floor to the Ground Floor.", time: "1 min")
                    NavigationStepView(icon: "signpost.right", step: "Follow signage toward Main Gate 1, then turn right.", time: "2 min")
                    NavigationStepView(icon: "fork.knife", step: "Find the Cafeteria adjacent to the gate.", time: "1 min")
                    
                    
                    
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
                        .padding(.horizontal)
                        .padding(.top, 5)
                  
                    Text("If you are stuck on somewhere, just change where you now and where you want to go, then again search for the direction from the stuck place.")
                        .foregroundColor(.gray)
                        .fontWeight(.medium)
                        .font(.caption)
                        .padding(.horizontal)
                }
                
              
            }
            .frame(height: 150)
            .padding()
            
            
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding()
    }
}





struct NavigatorVieww_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorView()
    }
}
