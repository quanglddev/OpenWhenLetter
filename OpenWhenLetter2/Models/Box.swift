//
//  Box.swift
//  OpenWhenLetter2
//
//  Created by QUANG on 8/26/18.
//  Copyright © 2018 QUANG. All rights reserved.
//

import UIKit
import ObjectMapper

class Box: Mappable {
    var boxID = ""
    var boxTitle = ""
    var adminID = ""
    var participants: [String] = []
    var letterIDs: [String] = []
    
    required init?(map: Map) {
        
    }
    
    init(boxID: String, boxTitle: String, adminID: String, participants: [String], letterIDs: [String]) {
        self.boxID = boxID
        self.boxTitle = boxTitle
        self.adminID = adminID
        self.participants = participants
        self.letterIDs = letterIDs
    }
    
    // Mappable
    func mapping(map: Map) {
        boxID      <- map["boxID"]
        boxTitle   <- map["boxTitle"]
        adminID    <- map["adminID"]
        letterIDs  <- map["letterIDs"]
    }
    
    static func createSamples() -> [Box] {
        return [Box(boxID: "738688fc-2df0-45aa-96da-7af39b549db8", boxTitle: "Family", adminID: "e20d2701-6802-4ffc-8faf-11ce08b7c1c5", participants: ["https://cdnb.artstation.com/p/assets/images/images/007/776/855/large/joachim-mcdonald-joachim-avatar-smooth2.jpg?1508434889", "http://www.facets.la/fullview/F_2014_364_OVERLORD_II.jpg", "http://www.facets.la/fullview/F_2014_365.jpg"], letterIDs: []),
                Box(boxID: "738688fc-2df0-45aa-96da-7af39b549db8", boxTitle: "Myself", adminID: "e20d2701-6802-4ffc-8faf-11ce08b7c1c5", participants: ["http://www.facets.la/fullview/F_2014_361_DARKWING.jpg", "http://www.facets.la/fullview/F_2014_364_OVERLORD_II.jpg", "http://www.facets.la/fullview/F_2014_365.jpg"], letterIDs: []),
                Box(boxID: "738688fc-2df0-45aa-96da-7af39b549db8", boxTitle: "Mom only", adminID: "e20d2701-6802-4ffc-8faf-11ce08b7c1c5", participants: ["http://www.facets.la/fullview/F_2014_360_TOTEM.jpg", "http://www.facets.la/fullview/F_2014_364_OVERLORD_II.jpg", "http://www.facets.la/fullview/F_2014_365.jpg"], letterIDs: [])]
    }
}
