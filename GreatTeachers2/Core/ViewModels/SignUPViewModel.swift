//
//  SignUPViewModel.swift
//  GreatTeachers2
//
//  Created by Macbook Pro on 05/02/25.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    
    
    @Published var isStudent: Bool = true
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var image: String = "https://picsum.photos/id/\(Int.random(in: 1..<100))/500/500"
    
    let dataManager: NetworkingManager = NetworkingManager.shared
    
    
    // Teacher-specific fields
    @Published var universityName: String = ""
    @Published var major: String = ""
    
    var passwordsMatch: Bool {
        return password == confirmPassword
    }
    
    var isSignUpEnabled: Bool {
        if isStudent {
            return !name.isEmpty && !surname.isEmpty && !username.isEmpty && !password.isEmpty && passwordsMatch
        }else {
            return !name.isEmpty && !surname.isEmpty && !username.isEmpty && !password.isEmpty && passwordsMatch && !universityName.isEmpty && !major.isEmpty
        }
    }
    
    func signUp() {
        if isStudent {
            let student = Student(id: UUID().uuidString, name: name, surname: surname, username: username, password: password, image: image)
            //print("Student signed up: \(student)")
            
            AFHttp.shared.post(url: AFHttp.API_STUDENTS, isComments: false, params: AFHttp.paramStudent(student: student)) { (result: Result<Student,Error>) in
                switch result {
                case .failure(let error):
                    print("Error: \(error)")
                case .success(let student):
                    print("Student name: \(student.name)")
                    self.dataManager.refreshBase()
                }
            }
            
            
        } else {
            let teacher = Teacher(id: UUID().uuidString, name: name, surname: surname, universityName: universityName, major: major, rating: 0.0, username: username, password: password, image: image)
            //print("Teacher signed up: \(teacher)")
            AFHttp.shared.post(url: AFHttp.API_TEACHERS, isComments: false, params: AFHttp.paramsTeacher(teacher: teacher)) { (result: Result<Teacher,Error>) in
                switch result {
                case .failure(let error):
                    print("Error: \(error)")
                case .success(let teacher):
                    print("Student name: \(teacher.name)")
                    self.dataManager.refreshBase()
                }
            }
        }
    }
}

