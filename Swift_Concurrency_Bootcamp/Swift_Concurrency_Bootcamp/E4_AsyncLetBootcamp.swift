//
//  E4_AsyncLetBootcamp.swift
//  Swift_Concurrency_Bootcamp
//
//  Created by Sagar Kadam on 02/11/23.
//

import SwiftUI

struct E4_AsyncLetBootcamp: View {
    
    @State private var images:[UIImage] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    
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
}

struct E4_AsyncLetBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        E4_AsyncLetBootcamp()
    }
}
