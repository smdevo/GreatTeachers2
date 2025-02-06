//
//  HomeView.swift
//  GreatTeachers
//
//  Created by Macbook Pro on 04/02/25.
//

import SwiftUI

struct HomeView: View {
   
    
    @StateObject var vm = HomeViewModel()
    

    @AppStorage("rolestudent") var rolestudent: Bool?

    @AppStorage("id") var id: String?

    @State var isFeed: Int = 1
    
    
    var body: some View {
        
       // NavigationStack {
            
            
            if vm.isLoading ?? true {
                ProgressView()
                
            }else {
                TabView(selection: $isFeed) {
                    
                    FeedView(vm: vm)
                        .tabItem {
                            Label("FeedView", systemImage: "house")
                        }
                        .tag(1)

                    
                    if rolestudent ?? true {
                        
                        UserProfileView(vm: vm, student: vm.currentStudent ?? DEVPreViews.shared.student)
                            .tabItem {
                                Label("UserProfileView", systemImage: "person")
                            }
                            .tag(2)
                        
                    }else {
                        
                        TeacherProfileView(vm: vm, teacher: vm.currentTeacher ?? DEVPreViews.shared.teacher)
                            .tabItem {
                                Label("Profile", systemImage: "person")
                            }
                            .tag(2)
                        
                    }
                    
                }
                .navigationTitle("Hello")
                
            }
            
    }
}

#Preview {
    HomeView()
}


