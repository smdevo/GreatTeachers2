//
//  Untitled.swift
//  GreatTeachers2
//
//  Created by Macbook Pro on 06/02/25.
//

import SwiftUI

class CacheManagerG {
    
    static var shared = CacheManagerG()
    private init() {
        
    }
    
    var imageCaches: NSCache<NSString, UIImage> = {
        let cache =  NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func saveIntoCache(key: String,image: UIImage) {
        imageCaches.setObject(image, forKey: key as NSString)
        print("Saving Image")
    }
    
    func getFromCach(key: String) -> UIImage? {
        return imageCaches.object(forKey: key as NSString)
    }
     
}
