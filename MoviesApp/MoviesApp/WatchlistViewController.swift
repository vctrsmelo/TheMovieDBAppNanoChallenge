//
//  WatchlistViewController.swift
//  MoviesApp
//
//  Created by Max Zorzetti on 02/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import Foundation
import UIKit

class WatchlistViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
	
	var viewModel: WatchlistViewModel!
	
	@IBOutlet weak var watchlistCollectionView: UICollectionView!
	
	@IBOutlet weak var alphabetCollectionView: UICollectionView!
	
	@IBOutlet weak var distancePosterLetters: NSLayoutConstraint!
	
	@IBOutlet weak var searchBarView: SearchBarView!
	
	@IBOutlet weak var titleLabel: UILabel!
	
	@IBOutlet weak var searchButton: UIButton!
	
	// MARK: View
	override func viewDidLoad() {
		self.viewModel = WatchlistViewModel(user: User(id: "TEMP"), view: self)
		
		self.watchlistCollectionView.dataSource = self
		self.watchlistCollectionView.delegate = self
		self.watchlistCollectionView.layer.masksToBounds = false
		
		self.alphabetCollectionView.dataSource = self
		self.alphabetCollectionView.delegate = self
		
		searchBarView.searchBarView.delegate = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		UIApplication.shared.statusBarView?.backgroundColor = .clear
		searchBarView.isToggledOn = false
		
		watchlistCollectionView.reloadData()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		if (UIDevice.current.userInterfaceIdiom == .pad) {
			if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
				self.distancePosterLetters.constant = 34
			} else {
				self.distancePosterLetters.constant = 72
			}
		}
		
		// Update poster size on rotation
		self.watchlistCollectionView.collectionViewLayout.invalidateLayout()
	}
	
	// MARK: Search
	@IBAction func touchUpInsideSearchButton(_ sender: UIButton) {
		searchBarView.toggleBar(on: true, animated: true)
		toggleFakeNavbar(false)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		toggleFakeNavbar(true)
		searchBarView.isToggledOn = false
		self.view.endEditing(true)
	}
	
	private func toggleFakeNavbar(_ visible: Bool) {
		UIView.animate(withDuration: 0.2) {
			self.titleLabel.alpha = visible ? 1 : 0
			self.searchButton.alpha = visible ? 1 : 0
		}
	}
	
	// MARK: Collection Views
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if (collectionView.tag == 0) {
			return viewModel.watchlist.count
			
		} else {
			return viewModel.alphabet.count
		}
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		if (collectionView.tag == 0) {
			self.performSegue(withIdentifier: "myWatchlistToDetails", sender: self)
			
		} else if (collectionView.tag == 1) {
			let selectedLetter = viewModel.alphabet[indexPath.item]
			
			for movie in viewModel.watchlist {
				guard let firstChar = movie.title?.uppercased().characters.first else {
					continue
				}
				
				let movieIndex = viewModel.watchlist.index(of: movie)
				//print(movie.title!)
				
				if (firstChar == selectedLetter) {
					watchlistCollectionView.scrollToItem(at: IndexPath(item:movieIndex! , section: 0), at: .centeredHorizontally, animated: true)
					break
				}
			}
		}
	}
	
	// MARK: Collection View Layout
	// DO NOT TOUCH
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		
		if (collectionView.tag == 0) {
			
			let smallPosterSize = CGSize(width: 136 + 7 + 7, height: 201 + 7 + 9) // These pluses are the shadow offsets :>
			let bigPosterSize = CGSize(width: 201 + 14, height: 295 + 16)
			
			switch (UIDevice.current.userInterfaceIdiom) {
			case .pad:
				if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
					return smallPosterSize
				} else {
					return bigPosterSize
				}
			case .phone:
				return smallPosterSize
			default:
				return smallPosterSize
			}
		} else {
			switch UIDevice.current.userInterfaceIdiom {
			case .pad:
				return CGSize(width: 40.2, height: 39)
			case .phone:
				return CGSize(width: 29.39, height: 28)
			default:
				return CGSize(width: 29.39, height: 28)
			}
		}
	}

//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//		
//		if (collectionView.tag == 0) {
//			
//			switch UIDevice.current.userInterfaceIdiom {
//			case .pad:
//				if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
//					return 20 - 7 - 7
//				} else {
//					return 29 - 7 - 7
//				}
//			case .phone:
//				return 20
//			default:
//				return 20
//			}
//			
//			
//		} else {
//			return 10
//		}
//		
//	}
}
