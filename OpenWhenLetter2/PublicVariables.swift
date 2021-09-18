//
//  PublicVariables.swift
//  OpenWhenLetter2
//
//  Created by QUANG on 8/26/18.
//  Copyright © 2018 QUANG. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import FirebaseDatabase

extension DefaultsKeys {
    static let username = DefaultsKey<String>("username")
    static let userID = DefaultsKey<String>("userID")
    static let userEmail = DefaultsKey<String>("userEmail")
    static let avatarURL = DefaultsKey<String>("avatarURL")
}

var currentUser: User!

var ref: DatabaseReference!
