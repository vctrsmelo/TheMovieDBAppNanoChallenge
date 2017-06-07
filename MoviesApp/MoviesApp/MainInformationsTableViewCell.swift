//
//  MainInformationsTableViewCell.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 05/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class MainInformationsTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieTime: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var watchlistButton: UIButton!
    @IBOutlet weak var rating1Button: UIButton!
    @IBOutlet weak var rating2Button: UIButton!
    @IBOutlet weak var rating3Button: UIButton!
    @IBOutlet weak var rating4Button: UIButton!
    @IBOutlet weak var rating5Button: UIButton!
    @IBOutlet weak var viewPhotoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func oneStarPressed(_ sender: UIButton) {
        rating1Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating2Button.setImage(UIImage(named: "Ic_Star"), for: UIControlState.normal)
        rating3Button.setImage(UIImage(named: "Ic_Star"), for: UIControlState.normal)
        rating4Button.setImage(UIImage(named: "Ic_Star"), for: UIControlState.normal)
        rating5Button.setImage(UIImage(named: "Ic_Star"), for: UIControlState.normal)
    }
    
    @IBAction func twoStarsPressed(_ sender: UIButton) {
        rating1Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating2Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating3Button.setImage(UIImage(named: "Ic_Star"), for: UIControlState.normal)
        rating4Button.setImage(UIImage(named: "Ic_Star"), for: UIControlState.normal)
        rating5Button.setImage(UIImage(named: "Ic_Star"), for: UIControlState.normal)
    }
    
    @IBAction func threeStarsPressed(_ sender: UIButton) {
        rating1Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating2Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating3Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating4Button.setImage(UIImage(named: "Ic_Star"), for: UIControlState.normal)
        rating5Button.setImage(UIImage(named: "Ic_Star"), for: UIControlState.normal)
    }
    
    @IBAction func fourStarsPressed(_ sender: UIButton) {
        rating1Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating2Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating3Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating4Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating5Button.setImage(UIImage(named: "Ic_Star"), for: UIControlState.normal)
    }
    
    @IBAction func fiveStarsPressed(_ sender: UIButton) {
        rating1Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating2Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating3Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating4Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating5Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
    }
}
