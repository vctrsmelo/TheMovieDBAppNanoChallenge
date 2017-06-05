//
//  WatchlistViewController.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 02/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import UIKit

public class WatchlistViewController: UIViewController, UICollectionViewDataSource {
	
	var viewModel: WatchlistViewModel!
	
	@IBOutlet weak var watchlistCollectionView: UICollectionView!
	
	@IBOutlet weak var alphabetCollectionView: UICollectionView!
	
	override public func viewDidLoad() {
		self.viewModel = WatchlistViewModel(user: User(id: "TEMP"), view: self)
		
		self.watchlistCollectionView.dataSource = self
		self.alphabetCollectionView.dataSource = self
		/*
		watchlistCollectionView.layer.shadowColor = UIColor.black.cgColor
		watchlistCollectionView.layer.shadowOffset = CGSize(width: 0, height: 1)
		watchlistCollectionView.layer.shadowOpacity = 1
		watchlistCollectionView.layer.shadowRadius = 1.0
		watchlistCollectionView.clipsToBounds = false
		watchlistCollectionView.layer.masksToBounds = false*/
	}
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if (collectionView.tag == 0) {
			return viewModel.watchlist.count + 5
			
		} else {
			return viewModel.alphabet.count
		}
	}
	
	public func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if (collectionView.tag == 0) {
			let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! WatchlistCollectionViewCell
			movieCell.posterImageView.image = UIImage(named: "images")
			return movieCell
			
		} else {
			let alphabetCell = collectionView.dequeueReusableCell(withReuseIdentifier: "letterCell", for: indexPath) as! WatchlistAlphabetCollectionViewCell
			alphabetCell.letterLabel.text = String(viewModel.alphabet[indexPath.row])
			return alphabetCell
		}
	}
	
}
