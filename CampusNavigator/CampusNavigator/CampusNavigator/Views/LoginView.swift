import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var pass: String = ""
    @State var loggedIn = false
    @State var showErr = false
    @State var loading = false
    @State var fieldFocus: Int? = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Green gradient background
                LinearGradient(gradient: Gradient(colors: [
                    Color.green.opacity(0.3),
                    Color.green.opacity(0.1),
                    Color.white
                ]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Logo
                    VStack {
                        Image(systemName: "map.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.green)
                            .background(Circle().fill(Color(.systemGray6)).frame(width: 120, height: 120))
                            .padding(.bottom, 10)
                        
                        Text("Campus Navigator")
                            .font(.title)
                            .bold()
                            .foregroundColor(.green)
                    }
                    .padding(.top, 60)
                    .padding(.bottom, 40)
                    
                    // Fields
                    VStack(spacing: 15) {
                        HStack {
                            Image(systemName: "envelope").foregroundColor(.green)
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                        }
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        
                        HStack {
                            Image(systemName: "lock").foregroundColor(.green)
                            SecureField("Password", text: $pass)
                        }
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    
                    // Login Button (now matching text field width)
                    Button(action: {
                        loading = true
                        showErr = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            loading = false
                            if email == "u" && pass == "1" {
                                loggedIn = true
                            } else {
                                showErr = true
                            }
                        }
                    }) {
                        if loading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                        } else {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                        }
                    }
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20) // Match text field padding
                    .padding(.top, 20)
                    
                    if showErr {
                        Text("Incorrect email or password")
                            .foregroundColor(.red)
                            .padding(.top, 10)
                    }
                    
                    Spacer()
                    
                    Button("Forgot password? Contact admin") {
                        // TODO: Implement contact
                    }
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding(.bottom, 20)
                }
            }
            .navigationDestination(isPresented: $loggedIn) {
                DashboardView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
