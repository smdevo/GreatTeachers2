//
//  TeacherCell.swift
//  GreatTeachers2
//
//  Created by Macbook Pro on 05/02/25.
//

import SwiftUI

struct TeacherCell: View {
    
    //let cacheManager = CacheManagerG.shared
    
    let teacher: Teacher
    
    var body: some View {
        HStack(spacing: 15) {
            // Teacher Image
            
            
            //Caching
            ImageViewCell(teacher: teacher)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            
            
            // Teacher Details
            VStack(alignment: .leading, spacing: 5) {
                Text("\(teacher.name) \(teacher.surname)")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                  HStack {

                    Text(teacher.major)
                        .font(.subheadline)
                        //.foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(teacher.universityName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    
                }
                
                // Rating
                HStack {
                    ForEach(0..<5) { index in
                        Image(systemName: teacher.rating > Double(index) ? (teacher.rating > Double(index) + 0.5 ? "star.fill" : "star.lefthalf.fill") : "star")
                            .foregroundColor(.yellow)
                    }
                    Text(String(format: "%.1f", teacher.rating))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.primary.opacity(0.5), radius: 5, x: 0, y: 3)
        
    }
}





#Preview {
    TeacherCell(teacher: Teacher(id: "1", name: "Sara", surname: "Johns", universityName: "Oxford", major: "Math", rating: 3.7, username: "sarahm", password: "hello", image: "https://picsum.photos/id/1/500/500"))
}


