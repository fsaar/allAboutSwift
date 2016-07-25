//: [<< Working with DispatchWorkItems](DispatchWorkItems)

//:### Working with Preconditions

import UIKit
import Foundation
import PlaygroundSupport
PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true

//: Working with Preconditions

let queue = DispatchQueue(label: "com.allaboutswift.dispatchgroup", attributes: .concurrent, target: .global())

queue.async {
    dispatchPrecondition(condition: .notOnQueue(DispatchQueue.main))
    print("running not on main queue")
}

DispatchQueue.main.async {
    dispatchPrecondition(condition: .onQueue(DispatchQueue.main))
    print("running  on main queue")
}


    

