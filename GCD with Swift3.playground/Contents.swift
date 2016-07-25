//:## GCD with Swift 3
import UIKit
import Foundation
import PlaygroundSupport
PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true
//:### Working with DispatchQueue


//: A simple serial Queue

let serialQueue = DispatchQueue(label: "com.allaboutswift.gcd.serial", attributes: [.serial], target: .global())

serialQueue.sync {
    print(" serialQueue ... ")
}

//: A concurrent Queue
let qeueu = DispatchQueue.global(attributes : .qosUserInteractive)

let concurrentBackgroundQueue = DispatchQueue(label: "com.allaboutswift.gcd.concurrrent", attributes: [.concurrent,.qosUtility], target: .global() )

concurrentBackgroundQueue.async {
    print(" concurrentBackgroundQueue .... ")
}


//: A delayed serialQueue

serialQueue.after(when: .now() + .seconds(1)) {
    print (" once more on serialQueue ")
}

//: A more elaborate delayed serialQueue with suspend and resume

serialQueue.suspend()

serialQueue.async {
    print (" a resumed serialQueue ")
}

DispatchQueue.global().after(when: .now() + .seconds(2)) {
    serialQueue.resume()
}


//: Scheduling concurrent operations

DispatchQueue.concurrentPerform(iterations: 10) {
    print("\($0). concurrentPerform")
}

//:**[Working with DispatchGroups](@DispatchGroups)**



