//
//  DetailMovieViewController.swift
//  EndTermTask
//
//  Created by Macbook Pro 2020 on 21.12.2020.
//  Copyright © 2020 Macbook Pro 2020. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleM.text = nameFilm
        voteM.text = voteFilm
        dateM.text = dateFilm
        overText.text = overTextFilm
//        photo.image = photoFilm
//

    }
    

    @IBOutlet weak var titleM: UILabel!
//    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var voteM: UILabel!
    @IBOutlet weak var dateM: UILabel!
    @IBOutlet weak var overText: UILabel!
    
//    var photoFilm = UIImage()
    var nameFilm = ""
    var voteFilm = ""
    var dateFilm = ""
    var overTextFilm = ""
    

}

