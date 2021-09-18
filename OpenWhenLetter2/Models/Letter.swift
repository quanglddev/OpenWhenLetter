//
//  Letter.swift
//  OpenWhenLetter2
//
//  Created by QUANG on 8/26/18.
//  Copyright © 2018 QUANG. All rights reserved.
//

import UIKit
import ObjectMapper

class Letter: Mappable {
    var letterID = ""
    var authorID = ""
    var condition = ""
    var body = ""
    
    required init?(map: Map) {
        
    }
    
    init(letterID: String, authorID: String, condition: String, body: String) {
        self.letterID = letterID
        self.authorID = authorID
        self.condition = condition
        self.body = body
    }
    
    // Mappable
    func mapping(map: Map) {
        letterID    <- map["letterID"]
        authorID    <- map["authorID"]
        condition   <- map["condition"]
        body        <- map["body"]
    }
}
