//
//  AASWeatherParser.swift
//  AsynchronousCoreData
//
//  Created by Frank Saar on 29/05/2016.
//  Copyright © 2016 SAMedialabs. All rights reserved.
//

import UIKit

typealias AASWeatherParserParseBlock = (rowElements : [String]) -> Void

final class AASWeatherParser {
    private let fileName : String
    private let parseBlock : AASWeatherParserParseBlock
    init(fileName : String,parseBlock : AASWeatherParserParseBlock ) {
        self.fileName = fileName
        self.parseBlock = parseBlock
    }
    
    func parse() {
        if let data = readFile(self.fileName), content = String(data: data,encoding: NSUTF8StringEncoding) {
            let lines = content.componentsSeparatedByString("\n").dropFirst()
            for line in lines {
                let elements = line.componentsSeparatedByString(",")
                self.parseBlock(rowElements: elements)
            }
        }

    }
}

private extension AASWeatherParser {
    func readFile(fileName : String) -> NSData? {
        var data: NSData? = nil
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "csv")
        
        if let path = path {
            data = try? NSData(contentsOfFile: path, options: NSDataReadingOptions(rawValue:0))
            
        }
        return data
    }
}

