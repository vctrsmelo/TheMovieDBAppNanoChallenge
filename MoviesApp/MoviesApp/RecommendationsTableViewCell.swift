//
//  RecommendationsTableViewCell.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 06/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class RecommendationsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let recommendedMovies: [Movie] = [Movie(id: "", title: "", originalTitle: "", genres: [], runtime: nil, releaseDateString: nil, overview: nil, poster: UIImage(named: "images")), Movie(id: "", title: "", originalTitle: "", genres: [], runtime: nil, releaseDateString: nil, overview: nil, poster: UIImage(named: "images")), Movie(id: "", title: "", originalTitle: "", genres: [], runtime: nil, releaseDateString: nil, overview: nil, poster: UIImage(named: "images"))]
    
    @IBOutlet weak var recommendationsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recommendationsCollectionView.dataSource = self
        recommendationsCollectionView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recommendationsCollectionView.dequeueReusableCell(withReuseIdentifier: "recommendationsCell", for: indexPath) as! RecommendationsCollectionViewCell
        cell.poster.image = recommendedMovies[indexPath.item].poster
        return cell
    }
}
