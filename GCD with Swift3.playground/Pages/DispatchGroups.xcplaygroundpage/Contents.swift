//: [<< Working with DispatchQueues](DispatchQueues)

//:### Working with DispatchGroups

import UIKit
import Foundation
import PlaygroundSupport
PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true

//: new API approach

let queue = DispatchQueue(label: "com.allaboutswift.dispatchgroup", attributes: .concurrent, target: .main)
let group = DispatchGroup()

queue.async (group: group) {
    print("doing stuff")
}

queue.async (group: group) {
    print("doing more stuff")
}

queue.async (group: group) {
    print("doing a lot more stuff")
}


group.notify(queue: DispatchQueue.main) {
    print("done doing stuff")
}

//: alternate API approach

group.enter()
queue.async (group: group) {
    print("doing stuff again")
    group.leave()
}

group.enter()
queue.async (group: group) {
    print("doing more stuff again ")
    group.leave()
}

group.enter()
queue.async (group: group) {
    print("doing a lot more stuff again")
    group.leave()
}

group.notify(queue: DispatchQueue.main) {
    print("done doing stuff again")
}


//: [>> Working with Dispatch work items](DispatchWorkItems)
