//
//  E7_CheckedContinuationBootcamp.swift
//  Swift_Concurrency_Bootcamp
//
//  Created by Sagar Kadam on 07/11/23.
//

import SwiftUI

class CheckedContinuationNetworkManager {
    
    func getData(url: URL) async throws -> Data {
        do {
           let (data, _) =  try await URLSession.shared.data(from: url, delegate: nil)
            return data
        }catch {
           throw error
        }
    }
    
    func getDataWithCheckedContinuation(url: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data,response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }.resume()
        }
    }
}

class CheckedContinuationViewModel : ObservableObject {
    
    @Published var image : UIImage? = nil
    let networkManager = CheckedContinuationNetworkManager()
    
    func getImage() async {
        guard let url = URL(string: "https://picsum.photos/300") else {
            return
        }
        do {
            let data = try await networkManager.getData(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        }catch {
            print(error.localizedDescription)
            
        }
    }
    
    func getImageWithContinuation() async {
        guard let url = URL(string: "https://picsum.photos/300") else {
            return
        }
        
        do {
            let data = try await networkManager.getDataWithCheckedContinuation(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run(body: {
                    self.image = image
                })
            }
        }catch {
            print(error)
        }
    }
}

struct E7_CheckedContinuationBootcamp: View {
    @StateObject private var viewModel = CheckedContinuationViewModel()
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            // await viewModel.getImage()
            await viewModel.getImageWithContinuation()
        }
    }
}

struct E7_CheckedContinuationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        E7_CheckedContinuationBootcamp()
    }
}
