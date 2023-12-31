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
               // self.images.append(UIImage(systemName: "heart.fill")!)
                Task {
                    do {
                        
                        async let fetchImage1 = fetchImage()
                        async let fetchImage2 = fetchImage()
                        async let fetchImage3 = fetchImage()
                        async let fetchImage4 = fetchImage()
                        async let fetchTitle = fetchTitle()
                        
                        let (image1, image2, image3, image4, myTitle) = await (try fetchImage1, try fetchImage2,  try fetchImage3, try fetchImage4, fetchTitle)
                        
                        self.images.append(contentsOf: [image1, image2, image3, image4])
                        print(myTitle)
                        
                        
//                        let image1 = try await fetchImage()
//                        self.images.append(image1)
//
//                        let image2 = try await fetchImage()
//                        self.images.append(image2)
//
//                        let image3 = try await fetchImage()
//                        self.images.append(image3)
//
//                        let image4 = try await fetchImage()
//                        self.images.append(image4)
                        
                    } catch {
                        
                    }
                }
                    
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
    
    func fetchTitle() async -> String {
        return "My Title"
    }
}

struct E5_AsyncLetBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        E5_AsyncLetBootcamp()
    }
}
