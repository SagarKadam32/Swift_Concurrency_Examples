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
    
    let isActive : Bool = true
    
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
    
    func getFinalTitle() throws -> String {
        if isActive {
            return "NEW FINAL TITLE !!"
        } else {
            throw URLError(.badServerResponse)
        }
    }
    
    func getFinalTitle1() throws -> String {
        if isActive {
            return "Updated Final Text"
        } else {
            throw URLError(.backgroundSessionWasDisconnected)
        }
    }
    
    func getAlwaysError() throws -> String? {
        throw URLError(.badURL)
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
        
        
        /*
        let result = dataManager.getTitleAsResult()
        
        switch result {
        case .success(let newTitle) :
            self.text = newTitle
        case .failure(let error) :
            self.text = error.localizedDescription
        }
        */
        
        

//        let newTitle = try? dataManager.getAlwaysError()
//        if let newTitle = newTitle {
//            self.text = newTitle
//        }
    
        
        do  {
            let newTitle = try? dataManager.getAlwaysError()
            if let newTitle = newTitle {
                self.text = newTitle
            }
            
            let finalTitle = try dataManager.getFinalTitle1()
            self.text = finalTitle
            
        }catch let error {
            self.text = error.localizedDescription
        }
        
        /*
        do {
            let newTitle = try dataManager.getFinalTitle()
            self.text = newTitle
        }catch let error {
            self.text = error.localizedDescription
        } */

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
