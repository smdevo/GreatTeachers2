//
//  FeedView.swift
//  GreatTeachers2
//
//  Created by Macbook Pro on 05/02/25.
//
import SwiftUI

struct FeedView: View {
    
    @ObservedObject var vm: HomeViewModel
    @FocusState var isFocused: Bool

    
    let majors = ["All", "science", "math", "biology", "chemistry", "geography"] // Example majors
    
    var body: some View {
        
        NavigationStack {
            VStack {
                HStack {
                    TextField("Search by name...", text: $vm.searchText)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 2)
                        )
                        .padding(.leading)
                        .focused($isFocused)
                    
                    Button(action: {
                        vm.sortAscending.toggle()
                    }) {
                        
                        Image(systemName: "arrow.down")
                            .foregroundColor(vm.sortAscending ? Color.red : Color.green)
                            .font(.title)
                            .fontWeight(.bold)
                            .rotationEffect(Angle(degrees: vm.sortAscending ? 0 : 180))
                            .animation(.default, value: vm.sortAscending)
                            
                        
                    }
                    .padding()
                }
                
                Picker("Filter by Major", selection: $vm.selectedMajor) {
                    ForEach(majors, id: \.self) { major in
                        Text(major)
                            .tag(major)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                ScrollView {
                  
                    LazyVStack {
                        
                        ForEach(vm.filteredTeachers) {teacher in
                            NavigationLink {
                                TeacherDetailView(vm: vm, teacher: teacher)
                            } label: {
                                TeacherCell(teacher: teacher)
                                    .padding(.horizontal)
                            }
                            
                        }
                        
                    }
                    .animation(.default, value: vm.sortAscending)
                }
                
                
//                List {
//                    ForEach(vm.filteredTeachers) { teacher in
//                       
//                        NavigationLink {
//                            TeacherDetailView(teacher: teacher)
//                        } label: {
//                            TeacherCell(teacher: teacher)
//                        }
//                        
//                    }
//                }
//                .listStyle(PlainListStyle())
            }
            .navigationTitle("Teachers")
            .onTapGesture {
                isFocused = false
            }
        }
    }
}

#Preview {
    FeedView(vm: HomeViewModel())
}


//import SwiftUI
//
//struct FeedView: View {
//    
//    @ObservedObject var vm: HomeViewModel
//    
//    var body: some View {
//        
//        NavigationStack {
//            
//            List {
//                ForEach(vm.teachers) {teacher in
//                    
//                    TeacherCell(teacher: teacher)
//                    
//                }
//            }
//            .listStyle(PlainListStyle())
//            .navigationTitle("Teachers")
//        }
//    }
//}
//
//#Preview {
//    FeedView(vm: HomeViewModel())
//}
