//
//  SignInView.swift
//  GreatTeachers
//
//  Created by Macbook Pro on 04/02/25.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var vm = SignInViewModel()
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State var showAlert: Bool = false
    
    
    @State private var showSignUp: Bool = false
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        
        
        ZStack {
            

            VStack(spacing: 20) {
                Text("Sign In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Picker("Role", selection: $vm.isStudent) {
                    Text("Student").tag(true)
                    Text("Teacher").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(height: 55)
                .padding(.horizontal)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                    )
                    .padding(.horizontal)
                    .focused($isFocused)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                    )
                    .padding(.horizontal)
                    .focused($isFocused)
                
                Button(action: {
                    if !username.isEmpty && !password.isEmpty {
                        isFocused = false
                        
                        showAlert = !vm.signingIn(username: username, password: password)
                    }
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(username.isEmpty || password.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(username.isEmpty || password.isEmpty || vm.isLoading ?? false)
                
                Button(action: {
                    showSignUp.toggle()
                }) {
                    Text("Don't have an account? Sign Up")
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $showSignUp) {
                    SignUpView(usenameB: $username, passwordB: $password, isStudent: $vm.isStudent)
                }
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Password or Username is incorrect"), message: Text("Password or username is wrong"), dismissButton: .default(Text("Ok"), action: {
                    username = ""
                    password = ""
                }))
            }
            
            
            if vm.isLoading ?? false {
                
                Color.gray.opacity(0.6).ignoresSafeArea()
                
                
                ProgressView()
            }
            
            
        }
    }
}


#Preview {
    SignInView()
}
