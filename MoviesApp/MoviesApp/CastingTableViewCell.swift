//
//  CastingTableViewCell.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 06/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class CastingTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let cast: [Actor] = [Actor(actorName: "Kakaroto", characterName: "Goku", photo: UIImage(named: "images")),
                         Actor(actorName: "Vegeta", characterName: "Sayajin King", photo: UIImage(named: "images")),
                         Actor(actorName: "Gohan", characterName: "Matou Cell", photo: UIImage(named: "images"))]
    
    @IBOutlet weak var castingCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        castingCollectionView.dataSource = self
        castingCollectionView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = castingCollectionView.dequeueReusableCell(withReuseIdentifier: "castingCell", for: indexPath) as! CastingCollectionViewCell
        cell.actorName.text = cast[indexPath.item].actorName.uppercased()
        cell.characterName.text = cast[indexPath.item].characterName
        cell.actorPhoto.image = cast[indexPath.item].photo
        return cell
    }
}
