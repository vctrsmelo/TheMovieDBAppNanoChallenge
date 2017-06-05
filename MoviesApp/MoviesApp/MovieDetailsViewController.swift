//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieTime: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var watchlistButton: UIButton!
    @IBOutlet weak var rating1Button: UIButton!
    @IBOutlet weak var rating2Button: UIButton!
    @IBOutlet weak var rating3Button: UIButton!
    @IBOutlet weak var rating4Button: UIButton!
    @IBOutlet weak var rating5Button: UIButton!
    @IBOutlet weak var viewPhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
