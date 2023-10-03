//
//  Swift_Concurrency_BootcampApp.swift
//  Swift_Concurrency_Bootcamp
//
//  Created by Sagar Kadam on 02/10/23.
//

import SwiftUI

@main
struct Swift_Concurrency_BootcampApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrollView {
                    ScrollViewReader { value in
                        
                        VStack(spacing: 20) {
                            Group {
                                
                                SectionMainView(sectionTitle: "Swift Concurrency", sectionTitleDescription: "Swift Concurrency is a major upgrade to the Swift language that completely changes how to write asynchronous code in Swift. This includes taking a deep dive into Async, Await, Actors, Tasks and more! These new features are INCREDIBLY powerful and I will be using them in all of my apps going forward!") {
                                    Example_Main()
                                }
                             }
                            .id(0)
                        }
                    }
                    .padding()
                 }
            }
        }
    }
}
