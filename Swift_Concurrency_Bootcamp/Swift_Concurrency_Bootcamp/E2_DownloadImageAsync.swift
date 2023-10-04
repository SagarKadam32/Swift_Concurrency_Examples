//
//  E2_DownloadImageAsync.swift
//  Swift_Concurrency_Bootcamp
//
//  Created by Sagar Kadam on 04/10/23.
//

import SwiftUI

class DownloadImageAsyncImageLoader {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let image = UIImage(data: data),
                let response = response as? HTTPURLResponse,
                response.statusCode <= 200 && response.statusCode < 300 else {
                completionHandler(nil, error)
                return
            }
            completionHandler(image,nil)
        }
        .resume()
    }
}

class DownloadImageViewModel : ObservableObject {
    
    @Published var image1 : UIImage? = nil
    let loader = DownloadImageAsyncImageLoader()
    
    func fetchImage() {
        loader.downloadWithEscaping { [weak self] image, error in
            if let image = image {
                DispatchQueue.main.async {
                    self?.image1 = image
                }
            }
        }
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
