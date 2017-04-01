//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Christina Bharara on 3/31/17.
//  Copyright © 2017 cabhara. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    func configureForImage(image: UIImage){
        memeImageView.image = image
        
    }
    
}
