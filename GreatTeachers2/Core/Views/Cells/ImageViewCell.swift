//
//  ImageViewCell.swift
//  GreatTeachers2
//
//  Created by Macbook Pro on 06/02/25.
//


import SwiftUI

struct ImageViewCell: View {
    
    
    @StateObject var vm: ImageViewCellVM
    
    init(teacher: Teacher) {
        _vm = StateObject(wrappedValue: ImageViewCellVM(teacher: teacher))
    }
    
    var body: some View {
        
        
        if vm.isLoading {
            ProgressView()
        }else if let image = vm.image {
            Image(uiImage: image)
                .resizable()
                
        }else {
            Circle()
        }
        
        
        
    }
}

//#Preview {
//    DownloadingImageView2(urlStr: "https://via.placeholder.com/600/92c952")
//}
