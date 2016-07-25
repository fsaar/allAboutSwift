//: [<< Working with DispatchWorkItems](DispatchWorkItems)

//:### Working with DispatchSources

import UIKit
import Foundation
import PlaygroundSupport
PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true

//: Working with Timers

//: Schedule one shot timer

let queue = DispatchQueue(label: "com.allaboutswift.dispatchtimer", attributes: .concurrent, target: .main)

let timer = DispatchSource.timer()
timer.scheduleOneshot(deadline: .now() + .seconds(1),leeway: .seconds(1))
timer.setEventHandler {
    print("hello world")
}
timer.activate()

// Schedule repeating timer

let timer2 = DispatchSource.timer(flags: DispatchSource.TimerFlags(rawValue: 0), queue: queue)

timer2.scheduleRepeating(deadline: .now(),interval: 1)
timer2.setEventHandler {
    print("hello world")
}
timer2.activate()

DispatchQueue.global().after(walltime: .now() + .seconds(3)) {
    timer2.cancel()
}


//: [>> Working with Preconditions](Preconditions)

