//
//  TeacherDetailView.swift
//  GreatTeachers
//
//  Created by Macbook Pro on 04/02/25.
//

import SwiftUI


struct TeacherDetailView: View {
    
    @ObservedObject var vm: HomeViewModel
    
    @AppStorage("rolestudent") var rolestudent: Bool?
    
    @Environment(\.dismiss) var dismiss
    
    let teacher: Teacher
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Profile Image
                if let imageUrl = URL(string: teacher.image) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(10)
                }
                
                // Name and Surname
                Text("\(teacher.name) \(teacher.surname)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // University and Major
                VStack(alignment: .leading, spacing: 8) {
                    Text("University: \(teacher.universityName)")
                        .font(.headline)
                    Text("Major: \(teacher.major)")
                        .font(.subheadline)
                }
                
                // Rating
                HStack {
                    Text("Rating:")
                        .font(.headline)
                    Text(String(format: "%.1f", teacher.rating))
                        .font(.headline)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.headline)
                }
                
                // Username
                Text("Username: @\(teacher.username)")
                    .font(.headline)
                
                
               
                    Text("Comments")
                    .font(.title3)
                    .fontWeight(.bold)
                    .fontDesign(.serif)
                
                
                ScrollView {
                    
                        if vm.teacherComments.isEmpty {
                            
                            VStack {
                                
                                Text("Bo'sh")
                                
                                Text("Halicha komment yo'q")
                                    .font(.subheadline)
                            }
                            
                        }else {
                            
                            LazyVStack(alignment: .trailing) {
                                
                            ForEach(vm.teacherComments) {comment in
                                CommentCell(name: vm.getStudNameByID(id: comment.studentId), message: comment.message)
                            }
                            
                        }
                    }
                }
                .padding()
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.3))
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                        
                )
                
                
                if rolestudent ?? true {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Baholash Tizimi")
                            .font(.headline)
                        
                        HStack {
                            
                            ForEach(1..<6) {i in
                                
                                Image(systemName: "star.fill")
                                    .font(.title)
                                    .foregroundStyle(Int(vm.rating) >= i ? Color.yellow : Color.gray)
                                    .onTapGesture {
                                        vm.rating = Double(i)
                                    }
                                    .animation(.spring, value: vm.rating)
                                
                            }
                            
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 2)
                            
                        )
                    }
                    
                    VStack(alignment: .leading) {
                        
                        Text("Fikringizni qoldiring")
                            .font(.headline)
                        
                        TextEditor(text: $vm.newcomments)
                                    .frame(height: 200)
                                    .border(Color.gray, width: 1)
                                    .background(Color.gray.opacity(0.3))
                                    //.padding()
                        
                        
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button {
//                            vm.creatingComment(idTeacher: teacher.id, idStudent: vm.currentStudent?.id ?? "1", message: vm.newcomments)
//                            vm.updatingTeacher(teacher: teacher, rating: (teacher.rating * vm.teachers.count + vm.rating) / (vm.teachers.count + 1))
                            dismiss()
                        } label: {
                            Text("Yetkazish")
                                .foregroundStyle(Color.white)
                                .font(.headline)
                                .padding()
                                .padding(.horizontal)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                )
                        }
                        .disabled(vm.rating == 0)
                    }
                    
                    
                }
                
                
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Teacher Details")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .onAppear {
            vm.getCommentsOFTeacherById(id: teacher.id)
        }
    }
}

#Preview {
    TeacherDetailView(vm: HomeViewModel(), teacher: DEVPreViews.shared.teacher)
}
