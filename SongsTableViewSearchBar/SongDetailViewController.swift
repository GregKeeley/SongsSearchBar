//
//  SongDetailViewController.swift
//  SongsTableViewSearchBar
//
//  Created by Gregory Keeley on 12/5/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController {

    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var song: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        songImage.image = #imageLiteral(resourceName: "loveSongs")
        songNameLabel.text = song?.name
        artistNameLabel.text = song?.artist
    }
}
