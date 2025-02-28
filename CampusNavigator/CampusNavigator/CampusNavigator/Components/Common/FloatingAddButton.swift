import SwiftUI

struct FloatingAddButton: View {
    var icon: String
    @Binding var showSheet: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    showSheet.toggle()
                }) {
                    Image(systemName: icon)
                        .font(.system(size: 24, weight: .bold))
                        .frame(width: 60, height: 60)
                        .background(Color.customDarkGreen)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .padding(.bottom, 100)
                .padding(.trailing, 23)
                .accessibilityLabel("Add New Item")
            }
        }
    }
}
