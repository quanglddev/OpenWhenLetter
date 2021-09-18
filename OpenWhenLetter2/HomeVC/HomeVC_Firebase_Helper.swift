//
//  HomeVC_Firebase_Helper.swift
//  OpenWhenLetter2
//
//  Created by QUANG on 8/26/18.
//  Copyright © 2018 QUANG. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftyJSON

extension HomeVC {
    func getBoxesID(completion: @escaping ([String]) -> ()){
        var keyOfBoxes = [String]()

        ref = Database.database().reference()
        print(currentUser!.ID)
        let boxesRef = ref.child("users").child(currentUser!.ID).child("boxes")
        boxesRef.observeSingleEvent(of: .value) { (snapshot) in
            keyOfBoxes = []
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                print(child.key)
                keyOfBoxes += [child.key]
            }
            let inboxesRef = ref.child("users").child(currentUser!.ID).child("inboxes")
            inboxesRef.observeSingleEvent(of: .value, with: { (inSnapshot) in
                for child in inSnapshot.children.allObjects as! [DataSnapshot] {
                    print(child.key)
                    keyOfBoxes += [child.key]
                }
                 completion(keyOfBoxes)
            })
        }
    }
    
    func getBoxesDetail(IDs: [String], completion: @escaping ([Box]) -> ()) {
        self.boxes.removeAll()
        
        print(IDs)
        ref = Database.database().reference()
        ref.observe(.value) { (rootSnapshot) in
            if let boxesRef = rootSnapshot.children.allObjects[0] as? DataSnapshot {
                for box in boxesRef.children.allObjects as! [DataSnapshot] {
                    var participantsID = [String]()
                    var lettersID = [String]()
                    
                    if IDs.contains(box.key) {
                        let jsonString = box.value as? String ?? ""
                        let newBox = Box(JSONString: jsonString)
                        print(newBox?.boxTitle ?? "")
                    }
                }
            }
        }
    }
}
