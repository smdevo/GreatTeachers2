//
//  SignUPView.swift
//  GreatTeachers
//
//  Created by Macbook Pro on 04/02/25.
//

import SwiftUI

struct SignUpView: View {

    @StateObject private var vm = SignUpViewModel()
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var isFocused: Bool
    
    @Binding var usenameB: String
    @Binding var passwordB: String
    @Binding var isStudent: Bool
    

    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Picker("Role", selection: $vm.isStudent) {
                        Text("Student").tag(true)
                        Text("Teacher").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(height: 55)
                    .padding()
                    
                    TextField("Name", text: $vm.name)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                        .padding(.horizontal)
                        .focused($isFocused)
                    
                    TextField("Surname", text: $vm.surname)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                        .padding(.horizontal)
                        .focused($isFocused)
                    
                    TextField("Username", text: $vm.username)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                        .padding(.horizontal)
                        .focused($isFocused)
                    
                    SecureField("Password", text: $vm.password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                        .padding(.horizontal)
                        .focused($isFocused)
                    
                    SecureField("Confirm Password", text: $vm.confirmPassword)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(vm.confirmPassword.isEmpty ? Color.primary : vm.passwordsMatch ? .green : .red))
                        .padding(.horizontal)
                        .focused($isFocused)
                    
                    if !vm.isStudent {
                        TextField("University Name", text: $vm.universityName)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                            .padding(.horizontal)
                            .focused($isFocused)
                            .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                        
                        TextField("Major", text: $vm.major)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                            .padding(.horizontal)
                            .focused($isFocused)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    }
                    
                    Button(action: {
                        isFocused = false
                        usenameB = vm.username
                        passwordB = vm.password
                        isStudent = vm.isStudent
                        vm.signUp()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(vm.isSignUpEnabled ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .disabled(!vm.isSignUpEnabled)
                }
                .padding()
                .animation(Animation.easeInOut, value: vm.isStudent)
            }
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Done")

                    .foregroundStyle(Color.blue)
                    .font(.headline)
                    .padding()
            }
        }
    }
}

#Preview {
    SignUpView(usenameB: .constant(""), passwordB: .constant(""), isStudent: .constant(true))
}
