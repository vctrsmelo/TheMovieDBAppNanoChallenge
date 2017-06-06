//
//  WatchlistAlphabetCollectionViewCell.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 05/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import UIKit

public class WatchlistAlphabetCollectionViewCell: UICollectionViewCell {
	
	private let unselectedColor = UIColor(colorLiteralRed: 8.0/255, green: 28.0/255, blue: 36.0/255, alpha: 0.3)
	private let selectedColor = UIColor(colorLiteralRed: 8.0/255, green: 28.0/255, blue: 36.0/255, alpha: 1)
	
	@IBOutlet weak var letterLabel: UILabel!
	
	
	
	override public var isSelected: Bool {
		didSet {
			if isSelected {
				letterLabel.textColor = selectedColor
			} else {
				letterLabel.textColor = unselectedColor
			}
		}
	}
		
}
