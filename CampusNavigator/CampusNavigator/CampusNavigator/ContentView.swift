import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                             startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    VStack {
                        Image(systemName: "map.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        
                        Text("Campus Navigator")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Your Guide to University Life")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.9))
                            .padding(.top, 8)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 260, height: 50)
                                .background(Color.green)
                                .cornerRadius(15)
                        }
                        
                        NavigationLink(destination: RegisterView()) {
                            Text("Register")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 260, height: 50)
                                .background(Color.blue)
                                .cornerRadius(15)
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Spacer()
                
                Image(systemName: "person.badge.plus")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                    .padding(.bottom, 10)
                
                Text("Create Account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
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
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    Button("Register") {
                        // Handle registration logic
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.3), lineWidth: 2))
                .padding(.horizontal, 10)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
    }
}



#Preview {
    ContentView()
}
