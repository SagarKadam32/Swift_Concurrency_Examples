//
//  E1_DoCatchTryThrowsBootcamp.swift
//  Swift_Concurrency_Bootcamp
//
//  Created by Sagar Kadam on 02/10/23.
//

import SwiftUI

// do-catch
// try
// throws

class DoCatchTryThrowsBootcampDataManager {
    
    let isActive : Bool = false
    
    func getTitle() -> String? {
        if isActive {
            return "NEW TITLE !!"
        }else {
            return nil
        }
    }
}

class DoCatchTryThrowsBootcampViewModel : ObservableObject {
    
    @Published var text : String = "Starting Text"
    let dataManager = DoCatchTryThrowsBootcampDataManager()
    
    func fetchTitle() {
        let newTitle = dataManager.getTitle()
        
        if let newTitle = newTitle {
            self.text = newTitle
        }
    }
    
}



struct E1_DoCatchTryThrowsBootcamp: View {
    
    @StateObject private var viewModel = DoCatchTryThrowsBootcampViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(Color.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

struct E1_DoCatchTryThrowsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        E1_DoCatchTryThrowsBootcamp()
    }
}
