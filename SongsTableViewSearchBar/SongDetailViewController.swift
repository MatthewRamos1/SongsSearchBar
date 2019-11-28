//
//  SongDetailViewController.swift
//  SongsTableViewSearchBar
//
//  Created by Matthew Ramos on 11/28/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController {

    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    var song: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func updateUI() {
        guard let setSong = song else {
            fatalError("Error setting song, check segue")
        }
        songImage.image = UIImage(named: "loveSongs")
        songTitle.text = setSong.name
        artistName.text = setSong.artist
        
    }
}
