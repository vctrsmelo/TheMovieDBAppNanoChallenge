//
//  MainInformationsTableViewCell.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 05/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class MainInformationsTableViewCell: UITableViewCell {

	weak var root: MovieDetailsViewController!
	
    
    var isFavorite: Bool! = false
    var isWatchlist: Bool! = false
    var isWatched: Bool! = false
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
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
    @IBOutlet weak var watchedButton: UIButton!
    @IBOutlet weak var viewPhotoButton: UIButton!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
     
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        isFavorite = !isFavorite
        
        if isFavorite {
            favoriteButton.setImage(UIImage(named: "ic_heart_select"), for: UIControlState.normal)
        } else {
            favoriteButton.setImage(UIImage(named: "ic_heart"), for: UIControlState.normal)
        }
    }
    
    @IBAction func watchlistPressed(_ sender: UIButton) {
        isWatchlist = !isWatchlist
        
        if isWatchlist {
            watchlistButton.setImage(UIImage(named: "ic_saved_select"), for: UIControlState.normal)
        } else {
            watchlistButton.setImage(UIImage(named: "ic_saved"), for: UIControlState.normal)
        }
    }
    
    @IBAction func oneStarPressed(_ sender: UIButton) {
        rating1Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating2Button.setImage(UIImage(named: "ic_star"), for: UIControlState.normal)
        rating3Button.setImage(UIImage(named: "ic_star"), for: UIControlState.normal)
        rating4Button.setImage(UIImage(named: "ic_star"), for: UIControlState.normal)
        rating5Button.setImage(UIImage(named: "ic_star"), for: UIControlState.normal)
    }
    
    @IBAction func twoStarsPressed(_ sender: UIButton) {
        rating1Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating2Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating3Button.setImage(UIImage(named: "ic_star"), for: UIControlState.normal)
        rating4Button.setImage(UIImage(named: "ic_star"), for: UIControlState.normal)
        rating5Button.setImage(UIImage(named: "ic_star"), for: UIControlState.normal)
    }
    
    @IBAction func threeStarsPressed(_ sender: UIButton) {
        rating1Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating2Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating3Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating4Button.setImage(UIImage(named: "ic_star"), for: UIControlState.normal)
        rating5Button.setImage(UIImage(named: "ic_star"), for: UIControlState.normal)
    }
    
    @IBAction func fourStarsPressed(_ sender: UIButton) {
        rating1Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating2Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating3Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating4Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating5Button.setImage(UIImage(named: "ic_star"), for: UIControlState.normal)
    }
    
    @IBAction func fiveStarsPressed(_ sender: UIButton) {
        rating1Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating2Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating3Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating4Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
        rating5Button.setImage(UIImage(named: "ic_star-1"), for: UIControlState.normal)
    }
    
    @IBAction func watchedPressed(_ sender: UIButton) {
		if self.isWatched {
			DataManager.user.removeWatchedMovie(id: self.root.testID)
			self.root.testBoolForPhoto = false
		} else {
			self.root.presentImagePicker()
		}
		
		self.isWatched = self.root.testBoolForPhoto
		
        if isWatched {
            watchedButton.setTitleColor(yearLabel.textColor, for: UIControlState.normal)
            watchedButton.borderColor = yearLabel.textColor
        } else {
            watchedButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            watchedButton.borderColor = UIColor.white
        }
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {

    }
}
