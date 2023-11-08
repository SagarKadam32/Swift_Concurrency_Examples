//
//  E8_StructClassActorBootcamp.swift
//  Swift_Concurrency_Bootcamp
//
//  Created by Sagar Kadam on 08/11/23.
//

import SwiftUI

struct E8_StructClassActorBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                runTest()
            }
    }
}

extension E8_StructClassActorBootcamp {
    
    private func runTest() {
        print("Test started..")
    }
}
