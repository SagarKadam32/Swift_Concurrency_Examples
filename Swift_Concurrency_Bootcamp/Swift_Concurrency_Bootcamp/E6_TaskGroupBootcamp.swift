//
//  E6_TaskGroupBootcamp.swift
//  Swift_Concurrency_Bootcamp
//
//  Created by Sagar Kadam on 04/11/23.
//

import SwiftUI

class TaskGroupViewModel : ObservableObject {
    @Published var images:[UIImage] = []

    
}

struct E6_TaskGroupBootcamp: View {
    @StateObject private var viewModel: TaskGroupViewModel = TaskGroupViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.images,id:\.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Task Group 😇")
        }
    }
}

struct E6_TaskGroupBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        E6_TaskGroupBootcamp()
    }
}
