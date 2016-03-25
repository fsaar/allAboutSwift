//
//  main.swift
//  OptionalProtocols
//
//  Created by Frank Saar on 23/03/2016.
//  Copyright © 2016 SAMedialabs. All rights reserved.
//

import Foundation

let server = NumberServer()
let numberProtocol = server as NumberServerProtocol
let number = numberProtocol.produceNumber()
let evenNumber = numberProtocol.produceEvenNumber!()
let oddNumber = numberProtocol.produceOddNumber!()
print(number)
print(evenNumber)
print(oddNumber)