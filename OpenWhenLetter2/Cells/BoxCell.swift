//
//  BoxCell.swift
//  OpenWhenLetter2
//
//  Created by QUANG on 8/26/18.
//  Copyright © 2018 QUANG. All rights reserved.
//

import UIKit
import Kingfisher

class BoxCell: UICollectionViewCell {
    
    //MARK: Variables
    var box: Box! {
        didSet {
            updateUI()
        }
    }
    
    //MARK: Outlets
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var boxTitleLabel: UILabel!
    
    //MARK: Functions
    private func updateUI() {
        boxTitleLabel.text = box.boxTitle
        featuredImageView.kf.setImage(with: URL(string: box.participants[0]))
        print(box.participants[0])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
