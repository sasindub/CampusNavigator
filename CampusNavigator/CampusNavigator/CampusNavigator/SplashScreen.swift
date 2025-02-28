import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
          
            LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.7), Color.white]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

       
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .opacity(isActive ? 0 : 1)

        }
        .onAppear {
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = true
                }
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            RegisterLoginView()
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
