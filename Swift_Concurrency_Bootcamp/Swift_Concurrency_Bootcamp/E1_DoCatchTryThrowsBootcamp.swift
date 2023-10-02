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
    
    func getTitleTupleResult() -> (title: String?, error :Error?) {
        if isActive {
            return ("NEW TITLE WITH TUPLE !!", nil)
        }else {
            return (nil, URLError(.badURL))
        }
        
    }
    
    func getTitleAsResult() -> Result<String, Error> {
        if isActive {
            return .success("NEW TEXT WITH RESULT !!")
        }else {
            return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
        }
    }
}

class DoCatchTryThrowsBootcampViewModel : ObservableObject {
    
    @Published var text : String = "Starting Text"
    let dataManager = DoCatchTryThrowsBootcampDataManager()
    
    func fetchTitle() {
        
        /*
        let newTitle = dataManager.getTitle()
        
        if let newTitle = newTitle {
            self.text = newTitle
        } */
        
        /*
        let returnedValue = dataManager.getTitleTupleResult()
        
        if let newTitle = returnedValue.title {
            self.text = newTitle
        } else if let error = returnedValue.error {
            self.text = error.localizedDescription
        } */
        
        
        let result = dataManager.getTitleAsResult()
        
        switch result {
        case .success(let newTitle) :
            self.text = newTitle
        case .failure(let error) :
            self.text = error.localizedDescription
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
