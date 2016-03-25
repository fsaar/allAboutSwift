//
//  SwiftNumberServer.swift
//  OptionalProtocols
//
//  Created by Frank Saar on 25/03/2016.
//  Copyright © 2016 SAMedialabs. All rights reserved.
//

import Foundation

@objc protocol NumberServerProtocol : class {
    func produceNumber() -> UInt
    optional func produceEvenNumber() -> UInt
    optional func produceOddNumber() -> UInt
}


class NumberServer : NSObject,NumberServerProtocol {
    func produceNumber() -> UInt {
        let number = arc4random() % 1000;
        return UInt(number);
    }
    
    func produceEvenNumber() -> UInt {
        let number = produceNumber()
        let evenNumber = (number % 2) == 0 ? (number == 0) ? number+2 : number : number+1;
        return evenNumber;
    }
    
    func produceOddNumber() -> UInt {
        return produceEvenNumber()+1;
    }
}