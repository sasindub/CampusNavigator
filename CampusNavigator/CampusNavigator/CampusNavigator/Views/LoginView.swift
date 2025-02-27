import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var isLoggedIn: Bool = false

    let validEmail = "student@nibm.lk"
    let validPassword = "password123"

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.7), Color.white]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .padding(.top, 50)

                    Text("Campus Navigator")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                        .foregroundColor(.customDarkGreen)

                    VStack(spacing: 10) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.gray)
                                .padding(.leading,1)
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                        }
                        .padding(.horizontal, 15)
                        .frame(height: 45)
                        .background(Color.white)
                        .cornerRadius(8)
             
                        .padding(.horizontal)
                      

                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.gray)
                                .padding(.leading, 1)
                            SecureField("Password", text: $password)
                        }
                        .padding(.horizontal, 15)
                        .frame(height: 45)
                        .background(Color.white)
                        .cornerRadius(8)
                        
                        .padding(.horizontal)
                    }

                    Button(action: {
                        validateLogin()
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.customDarkGreen)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .font(.title3)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    if showError {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.top, 5)
                    }

                    Spacer()

                    Text("Forgot password? Contact Admin")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    Text("admin@nibm.lk")
                        .font(.footnote)
                        .foregroundColor(.gray)

                   
                    NavigationLink(destination: DashboardView(), isActive: $isLoggedIn) {
                       
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    func validateLogin() {
        if email == validEmail && password == validPassword {
            showError = false
            isLoggedIn = true
        } else {
            showError = true
            errorMessage = "Invalid email or password. Try again."
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
