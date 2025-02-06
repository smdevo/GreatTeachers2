//
//  SignInViewModel.swift
//  GreatTeachers2
//
//  Created by Macbook Pro on 04/02/25.
//

import Foundation
import Combine

class SignInViewModel: ObservableObject {
    
    @Published var teachers: [Teacher] = []
    @Published var students: [Student] = []
    @Published var isLoading: Bool?
    
    @Published var isStudent: Bool = true
    @Published var isProcessing: Bool = false
    
    let dataManager: NetworkingManager = NetworkingManager.shared
    
    var cancelllables = Set<AnyCancellable>()
    
    
    init() {
        subscribingThePublishers()
    }
    
    
    func subscribingThePublishers() {
        
        dataManager.$teachers
            .sink { [weak self] teacherData in
                self?.teachers = teacherData
                
            }
            .store(in: &cancelllables)
        
        dataManager.$students
            .sink { [weak self] studentsData in
                self?.students = studentsData
            }
            .store(in: &cancelllables)
        
        dataManager.$isLoading
            .sink { [weak self] isLoading in
                self?.isLoading = isLoading
            }
            .store(in: &cancelllables)
        
    }
    
    
    func signingIn(username: String, password: String) -> Bool {
        
        var isExist = false
        
        if isStudent {
            students.forEach { student in
                isExist =  student.username.lowercased() == username.lowercased() && student.password.lowercased() == password.lowercased()
                
                if isExist {
                    UserDefaults.standard.set(student.id, forKey: "id")
                    UserDefaults.standard.set(true, forKey: "rolestudent")
                    UserDefaults.standard.set(true, forKey: "haslogged")
                }
            }
        }else {
            teachers.forEach { teacher in
                isExist =  teacher.username.lowercased() == username.lowercased() && teacher.password.lowercased() == password.lowercased()
                if isExist {
                    UserDefaults.standard.set(teacher.id, forKey: "id")
                    UserDefaults.standard.set(false, forKey: "rolestudent")
                    UserDefaults.standard.set(true, forKey: "haslogged")
                }
            }
        }
        
        
        
        return isExist
    }
    
    
}
