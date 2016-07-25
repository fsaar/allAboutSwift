//: [<< Working with DispatchGroups](DispatchGroups)

//:### Working with DispatchWorkItems

import UIKit
import Foundation
import PlaygroundSupport
PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true

//: Executing a work item

let item = DispatchWorkItem(group: nil, qos: .utility, flags: .detached) {
    print("work item")
}
item.perform()

//: Scheduling a work item on a Queue
let item2 = DispatchWorkItem() {
    print("work item2 ")
}
let queue = DispatchQueue(label: "com.allaboutswift.dispatchworkItem", attributes: .concurrent, target: .main)


queue.async(execute: item2)


//: Waiting for a work item to finish

let item3 = DispatchWorkItem() {
    print("work item3")
}
queue.async(execute: item3)
item3.notify(queue: .main) {
    print("item3 executed")
}


//: cancelling a work item
let item4 = DispatchWorkItem() {
    print("item4 executed)")
}
queue.after(when: .now() + .seconds(1), execute: item4)
item4.cancel()
item4.notify(queue: .main) {
    print("item4 cancel: \(item4.isCancelled)")
}

//: [>> Working with DispatchSources](DispatchSource)
