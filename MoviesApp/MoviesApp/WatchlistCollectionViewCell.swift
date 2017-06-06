//
//  WatchlistCollectionViewCell.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 05/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import UIKit

public class WatchlistCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var shadowView: UIView!
	
	@IBOutlet weak var posterImageView: UIImageView!
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		
		self.layer.masksToBounds = false
		self.clipsToBounds = true
		self.layer.shadowOpacity = 0.5
		self.layer.shadowRadius = 3.5
		self.layer.shadowOffset = CGSize(width: 1, height: 3)
		self.layer.shadowColor = UIColor.black.cgColor
	}
	
}
