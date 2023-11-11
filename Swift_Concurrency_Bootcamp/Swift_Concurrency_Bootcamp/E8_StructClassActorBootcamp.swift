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

class MyClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

extension E8_StructClassActorBootcamp {
    private func runTest() {
        print("Test started..")
//        structTest1()
//        classTest1()
        structTest2()
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
    
    private func classTest1() {
        let objectA = MyClass(title: "String Class Title.")
        print("Object A: ", objectA.title)
        print("Pass REFERENCE of Object-A TO Object-B")
        let objectB = objectA
        objectB.title = "Second Title!"
        print("Object B TItle changed")
        print("Object A: ",objectA.title)
        print("Object B: ",objectB.title)
    }
}

// Immutable Struct
struct CustomStruct {
    let title: String
    
    func updateTitle(newTitle: String) -> CustomStruct {
        return CustomStruct(title: newTitle)
    }
}

// Mutating Struct
struct MutatingStruct {
    var title: String
    
    mutating func udpateTitle(newTitle: String) {
        title = newTitle
    }
}

extension E8_StructClassActorBootcamp {
    private func structTest2() {
        print("structTest2")
        
        var struct1 = MyStruct(title: "Title1")
        print("Struct1",struct1.title)
        struct1.title = "Title2"
        print("Struct1",struct1.title)
        
        var struct2 = CustomStruct(title: "Title1")
        print("Struct2",struct2.title)
        struct2 = CustomStruct(title: "Title2")
        print("Struct2",struct2.title)
        
        var struct3 = CustomStruct(title: "TItle1")
        print("Struct3",struct3.title)
        struct3 = struct3.updateTitle(newTitle: "Title2")
        print("Struct3",struct3.title)
        
        var struct4 = MutatingStruct(title: "Title1")
        print("Struct4",struct4.title)
        struct4.udpateTitle(newTitle: "Title2")
        print("Struct4",struct4.title)

    }
}
