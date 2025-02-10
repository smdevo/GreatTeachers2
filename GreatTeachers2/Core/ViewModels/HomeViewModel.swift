//
//  HomeViewModel.swift
//  GreatTeachers2
//
//  Created by Macbook Pro on 05/02/25.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    let role: Bool = UserDefaults.standard.bool(forKey: "rolestudent")
    let id: String = UserDefaults.standard.string(forKey: "id") ?? "1"
    
    let dataManager: NetworkingManager = NetworkingManager.shared
    
    @Published var teachers: [Teacher] = []
    @Published var students: [Student] = []
    @Published var comments: [Comment] = []
    
    @Published var teacherComments: [Comment] = []
    
    @Published var currentStudent: Student?
    @Published var currentTeacher: Teacher?
    @Published var isLoading: Bool?
    
    @Published var searchText: String = ""
    @Published var selectedMajor: String = "All"
    @Published var sortAscending: Bool = true
    
    
    @Published var rating: Double = 0
    @Published var newcomments: String = "Fikrlar"
    
    var cancellables = Set<AnyCancellable>()
    
    var filteredTeachers: [Teacher] {
        var filtered = teachers
        
        if !searchText.isEmpty {
            filtered = filtered.filter { ($0.name + " " + $0.surname).lowercased().contains(searchText.lowercased()) }
        }
        
        if selectedMajor != "All" {
            filtered = filtered.filter { $0.major.lowercased() == selectedMajor.lowercased() }
        }
        
        return filtered.sorted { sortAscending ? $0.rating < $1.rating : $0.rating > $1.rating }
    }
    
    init() {
        subscribingThePublishers()
    }
    
    //subscribing
    func subscribingThePublishers() {
        dataManager.$teachers
            .sink { [weak self] teacherData in
                self?.teachers = teacherData
                self?.findCurrentUser()
            }
            .store(in: &cancellables)
        
        dataManager.$students
            .sink { [weak self] studentsData in
                self?.students = studentsData
                self?.findCurrentUser()
            }
            .store(in: &cancellables)
        
        dataManager.$comments
            .sink {[weak self] comments in
                self?.comments = comments
            }
            .store(in: &cancellables)
        
        dataManager.$isLoading
            .sink { [weak self] value in
                self?.isLoading = value
            }
            .store(in: &cancellables)
    }
    
    //findingCurrent User
    func findCurrentUser() {
        if role {
            students.forEach { student in
                if id == student.id {
                    currentStudent = student
                }
            }
        } else {
            teachers.forEach { teacher in
                if id == teacher.id {
                    currentTeacher = teacher
                }
            }
        }
    }
    
    
    //getting comments for Teachers comments
    func getCommentsOFTeacherById(id: String) {
        
        teacherComments = comments.filter { comment in
            return id == comment.teacherId
        }
        
    }
    
    //getting Student By Id
    func gettingStudById(id: String) -> Student? {
        
        var commentStudent: Student?
        
        students.forEach { student in
            if student.id == id {
                commentStudent = student
            }
        }
        
        return commentStudent
    }
    
    
    
    //Updating
    
    func creatingComment(idTeacher: String, idStudent: String, message: String) {
        
        let comment = Comment(id: UUID().uuidString, studentId: idStudent, teacherId: idTeacher, message: message)
        
        AFHttp.shared.post(url: AFHttp.API_COMMENTS, isComments: true, params: AFHttp.paramComment(comment: comment)) { (result: Result<Comment,Error>) in
            switch result {
            case .failure(let error):
                print("Error \(error)")
            case .success(let comment):
                print("Comment created id: \(comment.id)")
                self.dataManager.refreshBase()
            }
        }
        
    }
    
    //updating teacher
    
    func updatingTeacher(teacher: Teacher, newrating: Double) {
        
        let addingRating = newrating / Double(students.count)
        let totalRating = teacher.rating + addingRating
        
        //let newRating = (teacher.rating * teachers.count + rating) / (teachers.count + 1)
        
        let newTeacher = Teacher(id: teacher.id, name: teacher.name, surname: teacher.surname, universityName: teacher.universityName, major: teacher.major, rating: totalRating, username: teacher.username, password: teacher.password, image: teacher.image)
        
        AFHttp.shared.put(url: AFHttp.API_TEACHERS + newTeacher.id, isComments: false, params: AFHttp.paramsTeacher(teacher: newTeacher)) { (result: Result<Teacher,Error>) in
            switch result {
            case .success(let teacher):
                print("Updated Teacher: \(teacher.name)")
                self.rating = 0
                self.newcomments = "Fikrlar"
                self.dataManager.refreshBase()
            case .failure(let error):
                print("Error teacher: \(error)")
            }
        }
        
        
        
    }
    
    
    //Deleting Functions
    
    func deletingTeacherbyID(id: String){
        
        AFHttp.shared.delete(url: AFHttp.API_TEACHERS + id, isComments: false) { [self] (result: Result<Teacher, Error>) in
            switch result {
            case .success(let teacher):
                print("Deleted Teacher: \(teacher.name)")
                deletingReletedComments(byTeacherId: teacher.id)
            case .failure(let error):
                print("Error teacher: \(error)")
            }
        }
        
    }
    
    
    func deletingCommentById(id: String) {
        
        AFHttp.shared.delete(url: AFHttp.API_COMMENTS, isComments: true) { (result: Result<Comment, Error>) in
            switch result {
            case .success(let comment):
                print("Deleted Comment: \(comment.message)")
            case .failure(let error):
                print("Error Comment: \(error)")
            }
            
        }
        
    }
    
    
    func deletingReletedComments(byTeacherId: String) {
        
        teachers.forEach { teacher in
            if teacher.id == byTeacherId {
                
                deletingTeacherbyID(id: byTeacherId)
                
            }
        }
        UserDefaults.standard.set(false, forKey: "id")
    }
    
}
//import Foundation
//import Combine
//
//class HomeViewModel: ObservableObject {
//    
//    let role: Bool = UserDefaults.standard.bool(forKey: "rolestudent")
//    let id: String = UserDefaults.standard.string(forKey: "id") ?? "1"
//    
//    
//    let dataManager: NetworkingManager = NetworkingManager.shared
//
//    @Published var teachers: [Teacher] = []
//    @Published var students: [Student] = []
//    
//    @Published var currentStudent: Student?
//    @Published var currentTeacher: Teacher?
//    @Published var isLoading: Bool?
//    
//    
//    var cancelllables = Set<AnyCancellable>()
//
//    
//    init() {
//        subscribingThePublishers()
//    }
//    
//    func subscribingThePublishers() {
//        
//        dataManager.$teachers
//            .sink { [weak self] teacherData in
//                self?.teachers = teacherData
//                self?.findCurrentUser()
//                
//            }
//            .store(in: &cancelllables)
//        
//        dataManager.$students
//            .sink { [weak self] studentsData in
//                self?.students = studentsData
//                self?.findCurrentUser()
//            }
//            .store(in: &cancelllables)
//        
//        dataManager.$isLoading
//            .sink { [weak self] value in
//                self?.isLoading = value
//            }
//            .store(in: &cancelllables)
//        
//    }
//    
//    func findCurrentUser() {
//        
//        if role {
//            
//            students.forEach { student in
//                if id == student.id {
//                    currentStudent = student
//                }
//            }
//            
//        }else {
//            teachers.forEach { teacher in
//                if id == teacher.id {
//                    currentTeacher = teacher
//                }
//            }
//        }
//        
//    }
//    
//    
//}
