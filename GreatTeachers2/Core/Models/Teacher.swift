//
//  Teacher.swift
//  GreatTeachers
//
//  Created by Macbook Pro on 04/02/25.
//


struct Teacher: Identifiable, Codable {
    
    let id: String
    let name: String
    let surname: String
    let universityName: String
    let major: String
    let rating: Double
    let username: String
    let password: String
    let image: String
}
