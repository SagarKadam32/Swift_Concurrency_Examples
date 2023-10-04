//
//  E2_DownloadImageAsync.swift
//  Swift_Concurrency_Bootcamp
//
//  Created by Sagar Kadam on 04/10/23.
//

import SwiftUI
import Combine

class DownloadImageAsyncImageLoader {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode <= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
    
    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image,error)
        }
        .resume()
    }
    
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
}

class DownloadImageViewModel : ObservableObject {
    
    @Published var image1 : UIImage? = nil
    @Published var image2 : UIImage? = nil
    @Published var image3 : UIImage? = nil

    
    let loader = DownloadImageAsyncImageLoader()
    var cancellables = Set<AnyCancellable>()
    
    func fetchImage() {
        loader.downloadWithEscaping { [weak self] image, error in
            if let image = image {
                DispatchQueue.main.async {
                    self?.image1 = image
                }
            }
        }
        
        loader.downloadWithCombine()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] image in
                self?.image2 = image
            }
            .store(in: &cancellables)

    }
    
}

struct E2_DownloadImageAsync: View {
    
    @StateObject private var viewModel = DownloadImageViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Image Downlaod Using Closure :")
                    .bold()
                    
                if let image = viewModel.image1 {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                }
            }
            
            VStack {
                Text("Image Downlaod Using Combine :")
                    .bold()
                    
                if let image = viewModel.image2 {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                }
            }
        }
        .onAppear {
            viewModel.fetchImage()
        }
    }
}

struct E2_DownloadImageAsync_Previews: PreviewProvider {
    static var previews: some View {
        E2_DownloadImageAsync()
    }
}
