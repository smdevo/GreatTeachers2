//
//  Comment.swift
//  GreatTeachers
//
//  Created by Macbook Pro on 04/02/25.
//

struct Comment: Identifiable, Codable{

    let id: String
    let studentId: String
    let teacherId: String
    let message: String
}
