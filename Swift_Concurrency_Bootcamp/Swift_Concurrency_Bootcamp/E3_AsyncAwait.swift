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
        self.dataArray.append("Title1 : \(Thread.current)")
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
            viewModel.addTitle1()
        }
    }
}

struct E3_AsyncAwait_Previews: PreviewProvider {
    static var previews: some View {
        E3_AsyncAwait()
    }
}
