////
////  AFHttp.swift
////  GreatTeachers
////
////  Created by Macbook Pro on 04/02/25.
////
//
//
//import Foundation
//import Alamofire
//
//private let IS_TESTER = false
//
//private let DEP_SER = "https://67a0bb775bcfff4fabe063c7.mockapi.io/api/v1/" //teachers_students
//
//private let DEV_SER = "https://67a114875bcfff4fabe19c0f.mockapi.io/api/v1/" //comments
//
//
//
//class AFHttp{
//    
//    static let headers: HTTPHeaders = [
//        "Content-Type": "application/json"
//    ]
//
//    
//    static let shared = AFHttp()
//    
//    
//    class func get(url: String, isComments: Bool, params: Parameters, handler: @escaping (AFDataResponse<Data?>) -> Void) {
//        
//        guard let url = server(url: url, isComments: isComments) else {
//            print("In getting function error")
//            return
//        }
//        
//        AF.request(url, method: .get, parameters: params)
//            .validate(statusCode: 200..<300)
//            .response(completionHandler: handler)
//        
//    }
//    
//    
//    class func post(url: String, isComments: Bool, params: Parameters, handler: @escaping (AFDataResponse<Data?>) -> Void) {
//        
//        guard let url = server(url: url, isComments: isComments) else {
//            print("Eror while creating")
//            return
//        }
//        
//        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
//            .validate(statusCode: 200..<300)
//            .response(completionHandler: handler)
//    }
//    
//    
//    class func put(url: String, isComment: Bool, params: Parameters, handler: @escaping (AFDataResponse<Data?>) -> Void) {
//        guard let url = server(url: url, isComments: isComment) else {
//            print("Error Cant put")
//            return
//        }
//        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default)
//            .validate(statusCode: 200..<300)
//            .response(completionHandler: handler)
//        
//    }
//    
//    
//    class func del(url: String, isComment: Bool, params: Parameters, handler: @escaping (AFDataResponse<Data?>) -> Void) {
//        
//        guard let url = server(url: url, isComments: isComment) else {
//            print("Cannot Delete")
//            return
//        }
//        
//        
//        AF.request(url, method: .delete, parameters: params)
//            .validate(statusCode: 200..<300)
//            .response(completionHandler: handler)
//        
//    }
//    
//    
//    class func server(url: String, isComments: Bool) -> URL? {
//        if isComments {
//            return URL(string: DEV_SER + url)
//        }else  {
//            return URL(string: DEP_SER + url)
//        }
//    }
//    
//}
//
//
//extension AFHttp{
//    
//    // MARK : - AFHttp teacher Apies
//    static let API_TEACHERS = "teachers/"
//    static let API_STUDENTS = "students/"
//    static let API_COMMENTS = "comments/"
//    
//    
//    
//   
//    // MARK: - AFHttp Params| Auth
//    
//    class func paramsTeacher(teacher: Teacher) -> Parameters {
//        let parameters: Parameters = [
//            "name": teacher.name,
//            "surname": teacher.surname,
//            "universityName": teacher.universityName,
//            "major": teacher.major,
//            "rating": teacher.rating,
//            "username": teacher.username,
//            "password": teacher.password,
//            "image": teacher.image,
//            "id": teacher.id
//            
//        ]
//        
//        return parameters
//    }
//    
//    
//    class func paramStudent(student: Student) -> Parameters {
//            return [
//                "id": student.id,
//                "createdAt": student.createdAt ?? "",
//                "name": student.name,
//                "surname": student.surname,
//                "username": student.username,
//                "password": student.password,
//                "image": student.image
//            ]
//        }
//    
//    class func paramComment(comment: Comment) -> Parameters {
//        return [
//            "id": comment.id,
//            "createdAt": comment.createdAt ?? "",
//            "studentId": comment.studentId,
//            "teacherId": comment.teacherId,
//            "message": comment.message
//        ]
//    }
//    
//    
//    // MARK: - AFHttp Params| JOBS
//    class func paramsEmpty() -> Parameters{
//        let parameters: Parameters = [
//            :]
//        return parameters
//    }
//    
//}
