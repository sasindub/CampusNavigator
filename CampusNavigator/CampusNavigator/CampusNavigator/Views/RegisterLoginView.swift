import SwiftUI

struct RegisterLoginView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text("Campus Navigator")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Button(action: {}) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.customDarkGreen)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                    .font(.largeTitle)
            }
            
            Button(action: {}) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
            }
            
           
            
          
            
            Divider()
                .padding(.horizontal, 60)
                .padding(.vertical, 50)
            
            
            
            Text("Welcome to Campus Navigator")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.bottom, 5)
                .foregroundColor(.gray)
            
            Text("Your Smart Campus Guide! Easily find your way around, check real-time resources, stay updated on events, connect with lecturers, and share feedback—all in one place.")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

struct RegisterLoginView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterLoginView()
    }
}
