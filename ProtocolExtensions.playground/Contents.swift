
import UIKit

//: - Example: Let's define a protocol with a default implementation and a class
protocol Printable {
    func printMe() -> String
}

extension Printable {
    func printMe() -> String {
        return "Me:This is Printable"
    }
}

class P : Printable {
    func printMe() -> String {
        return "Me:This is P"
    }
}


let p1 : P = P()            // p1:Me:This is P
let p2  : Printable = P()   // p2:Me:This is P
let p3 = p1 as Printable    // p2:Me:This is P

//: - Important: The class overrides the default protocol implementation no matter if used as a protocol or a class.

print("p1:\(p1.printMe())")
print("p2:\(p2.printMe())")
print("p3:\(p3.printMe())")


//: - Example: Let's add a method to our protocol extension and override that method in our class
extension P {
    func printMe2() -> String {
        return "Me2:This is P"
    }
}

extension Printable {
    func printMe2() -> String {
        return "Me2:This is Printable"
    }
}

//: - Important: if the called method does only exist in the protocol extension but not in the protocol definition, then the protocol's default implementation in the extension will be called
print("p1:\(p1.printMe2())")
print("p2:\(p2.printMe2())")
print("p3:\(p3.printMe2())")

