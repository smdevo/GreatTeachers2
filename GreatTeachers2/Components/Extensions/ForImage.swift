//
//  ForImage.swift
//  GreatTeachers2
//
//  Created by Macbook Pro on 06/02/25.
//

import SwiftUI

extension Image {
    func toUIImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 200, height: 200)) // Set desired size
        return renderer.image { _ in
            UIImage(named: "example")?.draw(in: CGRect(x: 0, y: 0, width: 200, height: 200))
        }
    }
}

// Usage Example
let uiImage = Image("example").toUIImage()
