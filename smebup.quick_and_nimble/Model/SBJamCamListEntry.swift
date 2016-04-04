//
//  SBJamCamListEntry.swift
//  smebup
//
//  Created by Frank Saar on 16/02/2016.
//  Copyright © 2016 SAMedialabs. All rights reserved.
//

import Gloss
/*
[{
    "$type": "Tfl.Api.Presentation.Entities.Place, Tfl.Api.Presentation.Entities",
    "id": "JamCams_00002.00102",
    "url": "https://api-prod6.tfl.gov.uk/Place/JamCams_00002.00102",
    "commonName": "A406 Staples Corner",
    "placeType": "JamCam",
    "additionalProperties": [{
        "$type": "Tfl.Api.Presentation.Entities.AdditionalProperties, Tfl.Api.Presentation.Entities",
        "category": "payload",
        "key": "available",
        "sourceSystemKey": "JamCams",
        "value": "true",
        "modified": "2016-02-16T19:02:42.57"
        }, {
        "$type": "Tfl.Api.Presentation.Entities.AdditionalProperties, Tfl.Api.Presentation.Entities",
        "category": "payload",
        "key": "imageUrl",
        "sourceSystemKey": "JamCams",
        "value": "/tfl/livetravelnews/trafficcams/cctv/00002.00102.jpg",
        "modified": "2016-02-16T19:02:42.57"
        }, {
        "$type": "Tfl.Api.Presentation.Entities.AdditionalProperties, Tfl.Api.Presentation.Entities",
        "category": "payload",
        "key": "videoUrl",
        "sourceSystemKey": "JamCams",
        "value": "https://s3-eu-west-1.amazonaws.com/jamcams.tfl.gov.uk/00002.00102.mp4",
        "modified": "2016-02-16T19:02:42.57"
        }, {
        "$type": "Tfl.Api.Presentation.Entities.AdditionalProperties, Tfl.Api.Presentation.Entities",
        "category": "address",
        "key": "postCode",
        "sourceSystemKey": "JamCams",
        "value": "",
        "modified": "2016-02-16T19:02:42.57"
        }, {
        "$type": "Tfl.Api.Presentation.Entities.AdditionalProperties, Tfl.Api.Presentation.Entities",
        "category": "geo",
        "key": "osgr",
        "sourceSystemKey": "JamCams",
        "value": "TQ225874",
        "modified": "2016-02-16T19:02:42.57"
    }],
    "children": [],
    "childrenUrls": [],
    "lat": 51.5713,
    "lon": -0.23189
    }]
*/


public struct SBJamCamListEntry: Decodable {

    let identifier : String?
    let description: String?
    let imageURL : String?
    let videoURL : String?
    let type : String?
    
    // MARK: - Deserialization
    
    public init?(json: JSON) {
        self.identifier = "id" <~~ json
        self.description = "commonName" <~~ json
        self.imageURL = Decoder.decodeListEntry("imageUrl", json: json)
        self.videoURL =  Decoder.decodeListEntry("videoUrl", json : json)
        self.type = "placeType" <~~ json
    }
    
}

extension SBJamCamListEntry : CustomDebugStringConvertible {
    public var debugDescription: String {
        return (identifier ?? "") + (description ?? "") + "[" + (type ?? "") + "]\n"
    }
}

extension Decoder {
    static func decodeListEntry(key: String,  json : JSON)  -> String? {
        guard let additionalProperties = json["additionalProperties"] as? [[String:String]] else {
            return nil
        }
        let value = additionalProperties.filter { $0["key"] == key }.first?["value"]
        return value
    }
    
}