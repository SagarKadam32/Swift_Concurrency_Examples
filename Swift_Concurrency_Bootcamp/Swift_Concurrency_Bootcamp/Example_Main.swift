//
//  Example_Main.swift
//  Swift_Concurrency_Bootcamp
//
//  Created by Sagar Kadam on 03/10/23.
//

import SwiftUI

struct Example_Main: View {
    var body: some View {
        Group {
            NavigationLink(destination: E1_DoCatchTryThrowsBootcamp()) {
                Text("1. How to use Do, Try, Catch, and Throws in Swift")
            }
            
            NavigationLink(destination: E2_DownloadImageAsync()) {
                Text("2. Download images with Async/Await, @escaping, and Combine | Swift Concurrency")
            }
            
            NavigationLink(destination: E3_AsyncAwait()) {
                Text("3. How to use Async and Await")
            }
            
            NavigationLink(destination: TaskBootcampHomeView()) {
                Text("4. How to use Task and .task")
            }
        }
    }
}

struct SectionMainView<Content: View> : View {
    var sectionTitle = ""
    var sectionTitleDescription = ""
    @ViewBuilder var content : Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionHeader(sectionTitle:sectionTitle, sectionTitleDescription: sectionTitleDescription)
            content
                .frame(maxWidth: .infinity,alignment: .leading)
        }
        Divider()
    }
}

struct SectionHeader : View {
    var sectionTitle = ""
    var sectionTitleDescription = ""

    var body: some View {
        VStack(spacing:0) {
            Text(sectionTitle)
                .frame(maxWidth: .infinity, maxHeight: 35, alignment: .leading)
                .padding()
                .font(.title)
                .background(.mint)
            Text(sectionTitleDescription)
                .frame(maxWidth: .infinity, minHeight: 15, maxHeight: 25, alignment: .leading)
                .padding()
                .font(.headline.bold())
                .background(.yellow)
        }

    }
}

struct Example_Main_Previews: PreviewProvider {
    static var previews: some View {
        Example_Main()
    }
}
