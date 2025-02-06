//
//  StarterView.swift
//  GreatTeachers
//
//  Created by Macbook Pro on 04/02/25.
//

import SwiftUI

struct StarterView: View {
    
    @AppStorage("haslogged") var haslogged: Bool = false
    
    
    var body: some View {
        if haslogged  {
            HomeView()
//                .onAppear {
//                    haslogged = false
//                }
        }else {
            SignInView()
        }
    }
        
}

#Preview {
    StarterView()
}
