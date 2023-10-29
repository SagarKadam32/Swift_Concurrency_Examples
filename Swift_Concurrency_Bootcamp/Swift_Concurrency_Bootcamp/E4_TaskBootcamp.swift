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
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run {
                self.image =  UIImage(data: data)
                print("Image Loaded Successfully !!!")
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

struct TaskBootcampHomeView : View {
    
    var body: some View {
            NavigationLink("Click Me !!!"){
                E4_TaskBootcamp()
            }
    }
}

struct E4_TaskBootcamp: View {
    @StateObject private var viewModel = TaskBootcampViewModel()
    @State private var fetchImageTask : Task<(), Never>? = nil
    
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
        .task {
            await viewModel.fetchImage()
        }
        
//        .onDisappear {
//            fetchImageTask?.cancel()
//        }
//        .onAppear {
////            /*
////             Task {
////             print(Thread.current)
////             print(Task.currentPriority)
////             await viewModel.fetchImage()
////             }
////
////             Task {
////             print(Thread.current)
////             print(Task.currentPriority)
////             await viewModel.fetchImage2()
////             }
////             */
////
////            /*
////             Task(priority: .high) {
////              try? await Task.sleep(nanoseconds:2_000_000_000)
////
////             await Task.yield()
////             print("High : \(Thread.current) \(Task.currentPriority)")
////             }
////             Task(priority: .userInitiated) {
////             print("User Initiated : \(Thread.current) \(Task.currentPriority)")
////             }
////             Task(priority: .medium) {
////             print("Medium : \(Thread.current) \(Task.currentPriority)")
////             }
////             Task(priority: .low) {
////             print("Low : \(Thread.current) \(Task.currentPriority)")
////             }
////             Task(priority: .utility) {
////             print("Utility : \(Thread.current) \(Task.currentPriority)")
////             }
////             Task(priority: .background) {
////             print("Background : \(Thread.current) \(Task.currentPriority)")
////             }
////             */
////
////             Child Task & Detached Tasks
////
////                        Task(priority: .userInitiated) {
////                            print("User Initiated : \(Task.currentPriority)")
////
////                            Task {
////                                print("User Initiated : \(Task.currentPriority)")
////
////                            }
////                        }
////
////            /*
////             Task(priority: .low) {
////             print("Low : \(Task.currentPriority)")
////
////             Task.detached{
////             print("Detached : \(Task.currentPriority)")
////
////             }
////             }*/
//            
//            fetchImageTask = Task {
//                await viewModel.fetchImage()
//
//            }
//        }
            
        
    }
}

struct E4_TaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        E4_TaskBootcamp()
    }
}
