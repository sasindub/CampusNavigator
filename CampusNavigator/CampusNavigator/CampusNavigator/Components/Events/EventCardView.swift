import SwiftUI

struct EventCard: View {
    var event: Event

    var body: some View {
        VStack(spacing: 0) {
           
            Image(event.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 180)
                .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(event.title)
                    .font(.headline)
                    .foregroundColor(.black)
                
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.gray)
                    Text(event.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .fontWeight(.medium)
                }
                
                Text(event.description)
                    .foregroundColor(.black.opacity(0.7))
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .font(.callout)
                
                HStack {
                    Text("\(event.date) - \(event.time)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text(event.price)
                        .font(.headline)
                        .foregroundColor(.green)
                }
            }
            .padding()
            .background(Color.white)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
        .padding(.horizontal)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
