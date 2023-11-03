//
//  E4_AsyncLetBootcamp.swift
//  Swift_Concurrency_Bootcamp
//
//  Created by Sagar Kadam on 02/11/23.
//

import SwiftUI

struct E5_AsyncLetBootcamp: View {
    
    @State private var images:[UIImage] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let url = URL(string: "https://picsum.photos/300")!
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(images,id:\.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Async Let 😇")
            .onAppear {
                self.images.append(UIImage(systemName: "heart.fill")!)
                    
            }
        }
    }
    
    func fetchImage() async throws -> UIImage {
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

struct E5_AsyncLetBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        E5_AsyncLetBootcamp()
    }
}
