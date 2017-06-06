//
//  WatchlistViewController.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 02/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import UIKit

public class WatchlistViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
	var viewModel: WatchlistViewModel!
	
	@IBOutlet weak var watchlistCollectionView: UICollectionView!
	
	@IBOutlet weak var alphabetCollectionView: UICollectionView!
	
	override public func viewDidLoad() {
		self.viewModel = WatchlistViewModel(user: User(id: "TEMP"), view: self)
		
		self.watchlistCollectionView.dataSource = self
		self.watchlistCollectionView.delegate = self
		
		self.alphabetCollectionView.dataSource = self
	}
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if (collectionView.tag == 0) {
			return viewModel.watchlist.count
			
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
	
	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		if (collectionView.tag == 0) {
			self.performSegue(withIdentifier: "myWatchlistToDetails", sender: self)
			
		} else if (collectionView.tag == 1) {
			let selectedLetter = viewModel.alphabet[indexPath.item]
			
			for movie in viewModel.watchlist {
				guard let firstChar = movie.title?.uppercased().characters.first else {
					continue
				}
				
				let movieIndex = viewModel.watchlist.index(of: movie)
				
				if (firstChar == selectedLetter) {
					collectionView.scrollToItem(at: IndexPath(item:movieIndex! , section: 0), at: .centeredHorizontally, animated: true)
					break
				}
			}
			
		}
		
	}
}
