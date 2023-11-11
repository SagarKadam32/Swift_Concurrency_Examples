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

struct MyStruct {
    var title: String
}

extension E8_StructClassActorBootcamp {
    
    private func runTest() {
        print("Test started..")
        structTest1()

    }
    
    private func structTest1() {
        let objectA = MyStruct(title: "Starting Title.")
        print("Object A: ", objectA.title)
        
        print("Pass VALUES of Object-A TO Object-B")
        var objectB = objectA
        print("Object B: ", objectB.title)
        
        objectB.title = "Second Title!"
        
        print("Object B Title changed!")
        print("Object A: ", objectA.title)
        print("Object B: ", objectB.title)

        
        
        
    }
}
