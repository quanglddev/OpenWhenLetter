//
//  HomeVC.swift
//  OpenWhenLetter2
//
//  Created by QUANG on 8/25/18.
//  Copyright © 2018 QUANG. All rights reserved.
//

import UIKit


class HomeVC: UIViewController {
    
    //MARK: Variables
    var boxes = Box.createSamples()
    
    //MARK: Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getBoxesID { (results) in
            self.getBoxesDetail(IDs: results, completion: { (pulledBoxes) in
                print("done")
            })
        }
    }
}
