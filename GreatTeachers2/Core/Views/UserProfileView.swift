//
//  UserProfileView.swift
//  GreatTeachers
//
//  Created by Macbook Pro on 04/02/25.
//

import SwiftUI

import SwiftUI

struct UserProfileView: View {
    
    @AppStorage("haslogged") var haslogged: Bool = true

    @State var showAlert: Bool = false
    
    @ObservedObject var vm: HomeViewModel
    
    let student: Student
    
    var body: some View {
        
        NavigationStack {
            
            VStack(alignment: .center, spacing: 16) {
                // Profile Image
                AsyncImage(url: URL(string: student.image)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.gray)
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding(.top, 20)
                
                // Name and Surname
                Text("\(student.name) \(student.surname)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                
                
                // Additional Details
                VStack(alignment: .leading, spacing: 12) {
                    DetailRow(icon: "person", label: "Username", value: student.username)
                    DetailRow(icon: "lock", label: "Password", value: "••••••••") // Masked password
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.horizontal, 20)
                
                
                Button {
                    haslogged = false
                } label: {
                    Text("Log out")
                        .foregroundStyle(Color.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .black, radius: 5, x: 5, y: 5)
                }
                
                Spacer()
            }
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            .navigationTitle("Profile Student")
            //.navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAlert = true
                    } label: {
                        Text("Delete Account")
                            .font(.headline)
                            .foregroundStyle(Color.red)
                    }

                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Delete Account"), message: Text("Do you want to delete your account"), primaryButton: .destructive(Text("Delete"), action: {
                    //Not yet ready, I need to work on it
                    
                    haslogged = false
                }), secondaryButton: .cancel())
            }
        }
        
    }
}

// Custom View for Detail Rows
struct DetailRow: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

//#Preview {
//    UserProfileView(vm: HomeViewModel(), student: <#Student#>)
//}
