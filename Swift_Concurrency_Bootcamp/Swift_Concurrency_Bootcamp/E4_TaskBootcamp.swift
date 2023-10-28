//
//  E4_TaskBootcamp.swift
//  Swift_Concurrency_Bootcamp
//
//  Created by Sagar Kadam on 28/10/23.
//

import SwiftUI

class TaskBootcampViewModel : ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2 : UIImage? = nil
    
    func fetchImage() async {
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run {
                self.image =  UIImage(data: data)
            }
            
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run {
                self.image2 =  UIImage(data: data)
            }
            
        }catch {
            print(error.localizedDescription)
        }
    }
}

struct E4_TaskBootcamp: View {
    @StateObject private var viewModel = TaskBootcampViewModel()
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            if let image = viewModel.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchImage()
                await viewModel.fetchImage2()

            }
        }
    }
}

struct E4_TaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        E4_TaskBootcamp()
    }
}
