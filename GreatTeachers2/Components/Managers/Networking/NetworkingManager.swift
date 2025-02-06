//
//  NetworkingManager.swift
//  GreatTeachers2
//
//  Created by Macbook Pro on 05/02/25.
//


import Foundation
import Combine

class NetworkingManager {
    
    
    static var shared: NetworkingManager = NetworkingManager()
    
    @Published var teachers: [Teacher] = []
    @Published var students: [Student] = []
    @Published var comments: [Comment] = []
    @Published var isLoading: Bool = false

    
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        
        print("NetworkingManager init")
        
        refreshBase()
    }
    
    
    func refreshBase() {
        
        gettingTeachers()
        gettingStudents()
        gettingComments()
        
    }
    
    
    func gettingTeachers() {
        isLoading = true
        
        AFHttp.shared.get(url: AFHttp.API_TEACHERS, isComments: false) {[self] (result: Result<[Teacher],Error>) in
            switch result {
            case .success(let retTeachers):
                teachers = retTeachers
                isLoading = false
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func gettingStudents() {

        isLoading = true
        
        AFHttp.shared.get(url: AFHttp.API_STUDENTS, isComments: false) {[self] (result: Result<[Student],Error>) in
            switch result {
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            case .success(let returnedStudents):
                students = returnedStudents
                isLoading = false
            }
        }
        
    }
    
    func gettingComments() {

        isLoading = true
        AFHttp.shared.get(url: AFHttp.API_COMMENTS, isComments: true) {[self] (result: Result<[Comment],Error>) in
            switch result {
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            case .success(let returnedComments):
                comments = returnedComments
                isLoading = false
            }
        }
        
    }
    
    
    
    
}

