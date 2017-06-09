//
//  CastingTableViewCell.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 06/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class CastingTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var cast: [Actor] = [Actor(actorName: "Fulana", characterName: "Wonder Woman", photo: UIImage(named: "images")),
                         Actor(actorName: "Fulana", characterName: "Wonder Woman", photo: UIImage(named: "images")),
                         Actor(actorName: "Fulana", characterName: "Wonder Woman", photo: UIImage(named: "images"))]
    
    @IBOutlet weak var castingCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var castingCollectionViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var castingCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        castingCollectionView.dataSource = self
        castingCollectionView.delegate = self
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.current.orientation == .portrait {
                castingCollectionViewHeight.constant    = 241
                castingCollectionViewTop.constant       = 88
            } else {
                castingCollectionViewHeight.constant    = 241
                castingCollectionViewTop.constant       = 108
            }
        }
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
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.current.orientation == .portrait {
                cell.actorNameLabelHeight.constant      = 26
                cell.characterNameLabelHeight.constant  = 18
            } else {
                cell.actorNameLabelHeight.constant      = 26
                cell.characterNameLabelHeight.constant  = 18
            }
        }
        
        return cell
    }
}
