//
//  AFHTTPCombine.swift
//  GreatTeachers2
//
//  Created by Macbook Pro on 05/02/25.
//




import Foundation
import Combine




private let DEP_SER = "https://67a0bb775bcfff4fabe063c7.mockapi.io/api/v1/" // teachers_students
private let DEV_SER = "https://67a114875bcfff4fabe19c0f.mockapi.io/api/v1/" // comments

class AFHttp {
    
    static let shared = AFHttp()
    private var cancellables = Set<AnyCancellable>()
    
    private static func server(url: String, isComments: Bool) -> URL? {
        let baseURL = isComments ? DEV_SER : DEP_SER
        return URL(string: baseURL + url)
    }
    
    init() {
        print("AFHttp init")
    }
    
    
    // MARK: - GET Request
    func get<T: Decodable>(url: String, isComments: Bool, handler: @escaping (Result<T, Error>) -> Void) {
        guard let url = AFHttp.server(url: url, isComments: isComments) else {
            print("Error: Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    handler(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { data in
                handler(.success(data))
            })
            .store(in: &cancellables)
    }
    
    // MARK: - POST Request
    func post<T: Decodable, P: Encodable>(url: String, isComments: Bool, params: P, handler: @escaping (Result<T, Error>) -> Void) {
        guard let url = AFHttp.server(url: url, isComments: isComments) else {
            print("Error: Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(params)
        } catch {
            handler(.failure(error))
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    handler(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { data in
                handler(.success(data))
            })
            .store(in: &cancellables)
    }
    
    // MARK: - PUT Request
    func put<T: Decodable, P: Encodable>(url: String, isComments: Bool, params: P, handler: @escaping (Result<T, Error>) -> Void) {
        guard let url = AFHttp.server(url: url, isComments: isComments) else {
            print("Error: Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(params)
        } catch {
            handler(.failure(error))
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    handler(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { data in
                handler(.success(data))
            })
            .store(in: &cancellables)
    }
    
    // MARK: - DELETE Request
    func delete<T: Decodable>(url: String, isComments: Bool, handler: @escaping (Result<T, Error>) -> Void) {
        guard let url = AFHttp.server(url: url, isComments: isComments) else {
            print("Error: Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    handler(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { data in
                handler(.success(data))
            })
            .store(in: &cancellables)
    }
}

// MARK: - Parameter Helper Functions
extension AFHttp {
    static func paramsTeacher(teacher: Teacher) -> [String: AnyCodable] {
        return [
            "name": AnyCodable(teacher.name),
            "surname": AnyCodable(teacher.surname),
            "universityName": AnyCodable(teacher.universityName),
            "major": AnyCodable(teacher.major),
            "rating": AnyCodable(teacher.rating),
            "username": AnyCodable(teacher.username),
            "password": AnyCodable(teacher.password),
            "image": AnyCodable(teacher.image),
            "id": AnyCodable(teacher.id)
        ]
    }
    
    
    static func paramStudent(student: Student) -> [String: AnyCodable] {
        return [
            "id": AnyCodable(student.id),
            "name": AnyCodable(student.name),
            "surname": AnyCodable(student.surname),
            "username": AnyCodable(student.username),
            "password": AnyCodable(student.password),
            "image": AnyCodable(student.image)
        ]
    }
    


    
    static func paramComment(comment: Comment) -> [String: AnyCodable] {
        return [
            "id": AnyCodable(comment.id),
            "studentId": AnyCodable(comment.studentId),
            "teacherId": AnyCodable(comment.teacherId),
            "message": AnyCodable(comment.message)
        ]
    }
    
    static func paramsEmpty() -> [String: Any] {
        return [:]
    }
}

//MARK: API's

extension AFHttp {
    
    static let API_TEACHERS = "teachers/"
    static let API_STUDENTS = "students/"
    static let API_COMMENTS = "comments/"
        
    
}



/*
 Fetching Teachers (GET)
 
 AFHttp.shared.get(url: AFHttp.API_TEACHERS, isComments: false) { (result: Result<[Teacher], Error>) in
     switch result {
     case .success(let teachers):
         print("Teachers: \(teachers)")
     case .failure(let error):
         print("Error: \(error)")
     }
 }

 
 Adding a Teacher (POST)
 
 let newTeacher = Teacher(name: "John", surname: "Doe", universityName: "MIT", major: "Math", rating: 5, username: "jdoe", password: "12345", image: "", id: "101")

 AFHttp.shared.post(url: AFHttp.API_TEACHERS, isComments: false, params: newTeacher) { (result: Result<Teacher, Error>) in
     switch result {
     case .success(let teacher):
         print("Added Teacher: \(teacher)")
     case .failure(let error):
         print("Error: \(error)")
     }
 }

 
 Updating a Teacher (PUT Request)
 
 let updatedTeacher = Teacher(
     name: "Jane",
     surname: "Smith",
     universityName: "Harvard",
     major: "Physics",
     rating: 4.8,
     username: "janesmith",
     password: "newpassword",
     image: "",
     id: "101" // ID of the teacher to update
 )

 AFHttp.shared.put(url: "\(AFHttp.API_TEACHERS)\(updatedTeacher.id)", isComments: false, params: updatedTeacher) { (result: Result<Teacher, Error>) in
     switch result {
     case .success(let teacher):
         print("Updated Teacher: \(teacher)")
     case .failure(let error):
         print("Error: \(error)")
     }
 }

 Deleting a Teacher (DELETE Request)
 
 let teacherIdToDelete = "101" // ID of the teacher to delete

 AFHttp.shared.delete(url: "\(AFHttp.API_TEACHERS)\(teacherIdToDelete)", isComments: false) { (result: Result<Teacher, Error>) in
     switch result {
     case .success(let teacher):
         print("Deleted Teacher: \(teacher)")
     case .failure(let error):
         print("Error: \(error)")
     }
 }

 
 
 
 */
