//
//  RecommendationsTableViewCell.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 06/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class RecommendationsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var recommendedMovies: [Movie]!
    
    @IBOutlet weak var recommendationsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var recommendationsLabelLeading: NSLayoutConstraint!
    @IBOutlet weak var recommendationsLabelTrailing: NSLayoutConstraint!
    @IBOutlet weak var recommendationsLabelBottom: NSLayoutConstraint!
    
    @IBOutlet weak var recommendationsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recommendationsCollectionView.dataSource = self
        recommendationsCollectionView.delegate = self
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.current.orientation == .portrait {
                recommendationsCollectionViewHeight.constant    = 258
                recommendationsLabelLeading.constant            = 42 // Leading de todas as views
                recommendationsLabelTrailing.constant           = 48 // Trailing de todas as views
                recommendationsLabelBottom.constant             = 45
            } else {
                recommendationsCollectionViewHeight.constant    = 258
                recommendationsLabelLeading.constant            = 57 // Leading de todas as views
                recommendationsLabelTrailing.constant           = 63 // Trailing de todas as views
                recommendationsLabelBottom.constant             = 62
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recommendationsCollectionView.dequeueReusableCell(withReuseIdentifier: "recommendationsCell", for: indexPath) as! RecommendationsCollectionViewCell
        cell.posterButton.setImage(recommendedMovies[indexPath.item].poster, for: UIControlState.normal)
        return cell
    }
}
