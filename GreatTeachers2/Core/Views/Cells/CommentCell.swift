//
//  CommentCell.swift
//  GreatTeachers2
//
//  Created by Macbook Pro on 06/02/25.
//
import SwiftUI

struct CommentBubble: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let bubbleRadius: CGFloat = 12
        let tailSize: CGFloat = 10
        
        // Bubble shape
        path.addRoundedRect(in: CGRect(x: 0, y: 0, width: rect.width - tailSize, height: rect.height), cornerSize: CGSize(width: bubbleRadius, height: bubbleRadius))
        
        // Tail triangle
        path.move(to: CGPoint(x: rect.width - tailSize, y: rect.height * 0.5))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.55))
        path.addLine(to: CGPoint(x: rect.width - tailSize, y: rect.height * 0.7))
        path.closeSubpath()
        
        return path
    }
}

struct CommentCell: View {
    var profileImage: String?
    var name: String
    var message: String
    
    var body: some View {
       
       
        
        HStack(spacing: 10) {
            
            if
                let imageStr = profileImage,
                let url = URL(string: imageStr)
            {
                
                AsyncImage(url: url)
                
                
                // Profile Image
                //Image(imageStr)
                    //.resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
            }else {
                Image(systemName: "person.fill")
                    .foregroundStyle(Color.blue)
                    .font(.headline)
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }

            // Comment Bubble with Tail
            
                //ZStack(alignment: .bottomTrailing) {
                    VStack(alignment: .leading) {
                        
                        Text(name)
                            .font(.headline)
                        Text(message)
                            .font(.caption)
                            
                    }
                    .padding(12)
                        .background(Color.gray.opacity(0.8))
                        .clipShape(CommentBubble()) // Custom bubble shape
               // }
            
        }
        .padding(.horizontal)
    }
}





#Preview {
    CommentCell(profileImage: nil, name: "username", message: "Hello HelloHelloHello HelloHelloHello HelloHelloHello HelloHelloHello HelloHelloHello HelloHelloHello HelloHelloHello HelloHelloHello HelloHelloHello HelloHelloHello HelloHello ")
}
