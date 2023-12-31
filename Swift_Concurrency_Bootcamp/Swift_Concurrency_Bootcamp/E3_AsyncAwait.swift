//
//  E3_AsyncAwait.swift
//  Swift_Concurrency_Bootcamp
//
//  Created by Sagar Kadam on 07/10/23.
//

import SwiftUI

class AsyncAwaitViewModel : ObservableObject {
    
    @Published var dataArray : [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Title-1 : \(Thread.current)")
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "Title-2 : \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title)
                
                let title3 = "Title-3 : \(Thread.current)"
                self.dataArray.append(title3)
            }
        }
    }
    
    func addAuthor1() async {
        let author1 = "Author-1 : \(Thread.current)"
        dataArray.append(author1)
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let author2 = "Author-2 : \(Thread.current)"
        
        await MainActor.run {
            dataArray.append(author2)
        }
        
        let author3 = "Author-3 : \(Thread.current)"
        dataArray.append(author3)
        
    }
    
    func addSomething() async {
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let something1 = "Something-1 : \(Thread.current)"
        
        await MainActor.run {
            self.dataArray.append(something1)
            
            let something2 = "Something-2 : \(Thread.current)"
            dataArray.append(something2)
        }
    }
    
}

struct E3_AsyncAwait: View {
    @StateObject private var viewModel = AsyncAwaitViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
            Task {
                await viewModel.addAuthor1()
                await viewModel.addSomething()
                
                let finalText = "Final Text : \(Thread.current)"
                viewModel.dataArray.append(finalText)
            }
            
            /*
            viewModel.addTitle1()
            viewModel.addTitle2()
             */
        }
    }
}

struct E3_AsyncAwait_Previews: PreviewProvider {
    static var previews: some View {
        E3_AsyncAwait()
    }
}
