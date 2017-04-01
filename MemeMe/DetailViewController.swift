//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Christina Bharara on 3/31/17.
//  Copyright © 2017 cabhara. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var meme:Meme?
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        memeImageView.image = meme?.memed
    }
    
}
