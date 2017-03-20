//
//  Meme.swift
//  MemeMe
//
//  Created by Christina Bharara on 3/19/17.
//  Copyright © 2017 cabhara. All rights reserved.
//

import Foundation
import UIKit

struct Meme{
    var top:String = ""
    var bottom:String = ""
    var original:UIImage?
    var memed:UIImage?
    
    init(topText: String, bottomText:String, originalImage:UIImage, memedImage: UIImage) {
        top = topText
        bottom = bottomText
        original = originalImage
        memed = memedImage
    }
}
