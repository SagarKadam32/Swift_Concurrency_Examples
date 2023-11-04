//
//  E6_TaskGroupBootcamp.swift
//  Swift_Concurrency_Bootcamp
//
//  Created by Sagar Kadam on 04/11/23.
//

import SwiftUI

class TaskGroupDataManager {
    
    func fetchImagesWithAsyncLet() async throws -> [UIImage] {
        
        async let fetchImage1 = fetchImage(urlString:  "https://picsum.photos/300")
        async let fetchImage2 = fetchImage(urlString:  "https://picsum.photos/300")
        async let fetchImage3 = fetchImage(urlString:  "https://picsum.photos/300")
        async let fetchImage4 = fetchImage(urlString:  "https://picsum.photos/300")
        
        let (image1, image2, image3, image4) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4 )
        
        return [image1, image2, image3, image4]
    }
    
    private func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            if let image = UIImage(data: data){
                return image
            }else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
    
}

class TaskGroupViewModel : ObservableObject {
    @Published var images:[UIImage] = []
    let manager = TaskGroupDataManager()
    
    func getImages() async throws {
        if let images = try? await manager.fetchImagesWithAsyncLet() {
            self.images.append(contentsOf: images)
        }
    }
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
            .onAppear {
                Task {
                    try await viewModel.getImages()
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
