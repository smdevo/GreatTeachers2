//
//  ImageViewCellVM.swift
//  GreatTeachers2
//
//  Created by Macbook Pro on 06/02/25.
//

import Combine
import SwiftUI


class ImageViewCellVM: ObservableObject {
    
    let teacher: Teacher
    let cacheManager = CacheManagerG.shared
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    
    init(teacher: Teacher) {
        self.teacher = teacher
        if let cacheImage = cacheManager.getFromCach(key: "\(teacher.id)") {
            print("Getting Image")
            image = cacheImage
        }else {
            gettingImage()
        }
    }
    
    func gettingImage() {
        
        isLoading = true
        
        guard let url = URL(string: teacher.image) else {
            print("Invalid Url")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map { output in
                return UIImage(data: output.data) //?? UIImage(systemName: "xmark")
            }
            .sink { _ in
                
            } receiveValue: {[weak self] returnedImage in
                
                guard let self = self else {return}
                
                image = returnedImage
                isLoading = false
                if let image = image {
                    cacheManager.saveIntoCache(key: "\(teacher.id)", image: image)
                }
            }
            .store(in: &cancellables)
    }
    
    
}
