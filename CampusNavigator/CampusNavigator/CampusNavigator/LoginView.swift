import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isAuthenticated = false
    @State private var showError = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.green)
                        .padding(.bottom, 10)

                    Text("Campus Navigator")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    
                    VStack(spacing: 16) {
                        TextField("University Email", text: $email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)

                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)

                        NavigationLink(destination: DashboardView().navigationBarBackButtonHidden(true), isActive: $isAuthenticated) {
                            EmptyView()
                        }

                        Button("Login") {
                            if email == "u" && password == "1" {
                                isAuthenticated = true
                            } else {
                                showError = true
                            }
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)

                        if showError {
                            Text("Invalid credentials. Try again.")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.3), lineWidth: 2))
                    .padding(.horizontal, 10)

                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
