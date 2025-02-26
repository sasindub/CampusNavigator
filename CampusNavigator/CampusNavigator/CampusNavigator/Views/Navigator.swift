import SwiftUI
import MapKit
import CoreLocation

struct NavigatorView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )
    @State private var searchText = ""
    @State private var searchTextDe = ""
    @State private var isNavigating = false
    @State private var isExpanded = false
    
    var body: some View {
        ZStack(alignment: .top) {
            // Map View
            Map(
                coordinateRegion: $region,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow)
            )
            .ignoresSafeArea(.all)
            
            // Search Bars
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.customDarkGreen)
                    TextField("Enter destination", text: $searchText)
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .onTapGesture { searchText = "" }
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 5)
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.customDarkGreen)
                    TextField("Current location", text: .constant(""))
                        
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 5)
                .padding(.horizontal)
            }
            .padding(.top)
            
            // Navigation Controls
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isNavigating.toggle()
                    }) {
                        HStack {
                            Image(systemName: "arrow.up.right.circle.fill")
                                .foregroundColor(.white)
                            Text(isNavigating ? "Stop Navigation" : "Start Navigation")
                                .foregroundColor(.white)
                                .bold()
                        }
                        .padding()
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                    }
                    .padding()
                }
            }
        }
        .overlay(
            Group {
                if isNavigating {
                    CollapsedDirectionsPanel(isExpanded: $isExpanded)
                        .transition(.move(edge: .bottom))
                }
            },
            alignment: .bottom
        )
        .sheet(isPresented: $isExpanded) {
            FullDirectionsView()
        }
    }
}



struct NavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatorView()
    }
}
