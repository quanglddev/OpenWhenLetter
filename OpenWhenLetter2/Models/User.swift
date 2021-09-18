//
//  User.swift
//  OpenWhenLetter2
//
//  Created by QUANG on 8/26/18.
//  Copyright © 2018 QUANG. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Mappable {
    var ID = ""
    var name = ""
    var email = ""
    var avaURL = ""
    
    required init?(map: Map) {
        
    }
    
    init(ID: String, name: String, email: String, avaURL: String) {
        self.ID = ID
        self.name = name
        self.email = email
        self.avaURL = avaURL
    }
    
    func mapping(map: Map) {
        ID       <- map["ID"]
        name     <- map["name"]
        email    <- map["email"]
        avaURL   <- map["avaURL"]
    }
}
