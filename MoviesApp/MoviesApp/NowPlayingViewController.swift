//
//  NowPlayingViewController.swift
//  MoviesApp
//
//  Created by Victor S Melo on 05/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit


extension CALayer {
    
    func addBorder(edge: UIRectEdge, border: CALayer, color: UIColor, thickness: CGFloat){
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
            
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: CGFloat(self.frame.size.height - thickness), width: self.frame.size.width, height: thickness)
            break
            
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: thickness, height: self.frame.size.height)
            //CGRectMake(0, 0, thickness, CGRectGetHeight(self.frame))
            break
        case UIRectEdge.right:
            border.frame = CGRect.init(x: CGFloat(self.frame.size.width - thickness), y: 0, width: thickness, height: self.frame.size.height)
            //CGRectMake(CGRectGetWidth(self.frame) - thickness, 0, thickness, CGRectGetHeight(self.frame))
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
        
    }
    
}

class NowPlayingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    private var collectionLayout : UICollectionViewFlowLayout!
    
    @IBOutlet weak var searchBarView: SearchBarView!
    
    @IBOutlet weak var alphabetCollectionView: UICollectionView!
    private var currentSelectedAlphabetIndex : IndexPath?
    private var currentSelectedMovie: Movie?
    
    private var movieForSegue: Movie?

    private var viewModel : NowPlayingViewModel!
    
	private var posterSize: CGSize {
		get {
			if UIDevice.current.userInterfaceIdiom == .pad {
				if !(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
					return CGSize(width: 416, height: 616)
				} else {
					return CGSize(width: 252, height: 373)
				}
			} else {
				return CGSize(width: 215, height: 322)
			}
		}
	}
    private var posterOriginY : CGFloat?
    
    @IBOutlet weak var nowPlayingButton: UIButton!
    private var nowPlayingBorder = CALayer()
    
    @IBOutlet weak var upcomingButton: UIButton!
    private var upcomingBorder = CALayer()
    
    private var isNowPlayingCurrentContent = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
		nowPlayingCollectionView.layer.masksToBounds = false
		
        alphabetCollectionView.delegate = self
        alphabetCollectionView.dataSource = self
		
        
        let countryCode = (Locale.current.regionCode != nil) ? (Locale.current.regionCode!) : "US"
        
        viewModel = NowPlayingViewModel(view: self, isNowPlayingList: true, countryCode: countryCode)
        
        self.alphabetCollectionView.reloadData()
        self.alphabetCollectionView.setNeedsLayout()
		
        upcomingBorder.isHidden = true
        
        collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.sectionInset = UIEdgeInsetsMake(-10, 53, 0, 53)
        collectionLayout.minimumInteritemSpacing = 51
        collectionLayout.minimumLineSpacing = 51
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = posterSize
        
        nowPlayingCollectionView.collectionViewLayout = collectionLayout
        
        searchBarView.searchBarView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == nowPlayingCollectionView && isNowPlayingCurrentContent) {

            return viewModel.nowPlayingMovies.count
            
        } else if (collectionView == nowPlayingCollectionView && !isNowPlayingCurrentContent){
            return viewModel.upcomingMovies.count
            
        }else{
            return viewModel.alphabet.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == nowPlayingCollectionView){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingMovieCell", for: indexPath) as! NowPlayingMovieCell
            

			
			if (UIDevice.current.userInterfaceIdiom == .phone) {
				//first movie being added
				if(posterOriginY == nil){
					
					posterOriginY = cell.frame.origin.y
					
				}
				
				var frame = cell.frame
				
				frame.size.width = posterSize.width
				frame.size.height = posterSize.height
				frame.origin.y = posterOriginY!
				
				
				cell.frame = frame
				let cellFrame = nowPlayingCollectionView.convert(cell.frame, to: nowPlayingCollectionView.superview)
				cell.updateSize(cellFrame: cellFrame, container: self.nowPlayingCollectionView.frame)
				
				if(cell.getFeaturedPerentage() > 50){
					
					currentSelectedMovie = isNowPlayingCurrentContent ? viewModel.nowPlayingMovies[indexPath.item] : viewModel.upcomingMovies[indexPath.item]
					alphabetCollectionView.reloadData()
				}
			}
			
            currentSelectedMovie = isNowPlayingCurrentContent ? viewModel.nowPlayingMovies[indexPath.item] : viewModel.upcomingMovies[indexPath.item]
            
            //rounded corners
            cell.posterImageView.image = isNowPlayingCurrentContent ? viewModel.nowPlayingMovies[indexPath.item].poster :  viewModel.upcomingMovies[indexPath.item].poster
            cell.posterImageView.layer.masksToBounds = true
            cell.posterImageView.layer.cornerRadius = 4

            //shadow
            cell.adjustShadow()
            return cell
            
        }else{ //alphabet collection view
            
            
            let alphabetCell = collectionView.dequeueReusableCell(withReuseIdentifier: "letterCell", for: indexPath) as! WatchlistAlphabetCollectionViewCell
            alphabetCell.letterLabel.text = String(viewModel.alphabet[indexPath.item])
            
            if let movieTitle = currentSelectedMovie?.title, let cellTitle = alphabetCell.letterLabel.text{
                
                if movieTitle.characters.first == cellTitle.characters.first{
                    
                    if currentSelectedAlphabetIndex == nil{
                        
                        self.currentSelectedAlphabetIndex = indexPath
                        
                    }
                    
                    collectionView.cellForItem(at: currentSelectedAlphabetIndex!)?.isSelected = false
                    alphabetCell.isSelected = true
                    
                    currentSelectedAlphabetIndex = indexPath
                    
                }
                

            }
    
            return alphabetCell
            
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

		if (UIDevice.current.userInterfaceIdiom == .phone) {
		
			for cell in nowPlayingCollectionView.visibleCells{
				
				if let nowPlayingCell = cell as? NowPlayingMovieCell{
					
					let cellFrame = nowPlayingCollectionView.convert(nowPlayingCell.frame, to: nowPlayingCollectionView.superview)
					nowPlayingCell.updateSize(cellFrame: cellFrame, container: nowPlayingCollectionView.frame)
					
				   /* if(nowPlayingCell.getFeaturedPerentage() > 50){
							
					
						if let movieIndex = nowPlayingCollectionView.indexPath(for: nowPlayingCell) {
							
							
							currentSelectedMovie = isNowPlayingCurrentContent ? viewModel.nowPlayingMovies[movieIndex.row] : viewModel.upcomingMovies[movieIndex.row]
							alphabetCollectionView.reloadData()

							alphabetCollectionView.scrollToItem(at: currentSelectedAlphabetIndex!, at: UICollectionViewScrollPosition.right, animated: false)
						}
					}*/
					
					//shadow adjustment
					nowPlayingCell.adjustShadow()
					
				}
				
			}
		}
		
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }

    @IBAction func nowPlayingButtonTouched(_ sender: UIButton) {
        
        if isNowPlayingCurrentContent { return }
        isNowPlayingCurrentContent = true
        
        upcomingBorder.isHidden = true
        nowPlayingBorder.isHidden = false

        if(viewModel.nowPlayingMovies.isEmpty){
            
            let countryCode = (Locale.current.regionCode != nil) ? (Locale.current.regionCode!) : "US"
            viewModel.getNowPlayingMovies(countryCode: countryCode)

        }else{

            self.nowPlayingCollectionView.reloadData()
            
        }

    }
    
    
    @IBAction func upcomingButtonTouched(_ sender: UIButton) {

        if !isNowPlayingCurrentContent { return }
        isNowPlayingCurrentContent = false
        
        nowPlayingBorder.isHidden = true
        upcomingBorder.isHidden = false
        
        if viewModel.upcomingMovies.isEmpty{
            let countryCode = (Locale.current.regionCode != nil) ? (Locale.current.regionCode!) : "US"
            viewModel.getUpcomingMovies(countryCode: countryCode)
            
        }else{
            self.nowPlayingCollectionView.reloadData()
        }
    
    }
	
	override func viewDidLayoutSubviews() {
		super.viewWillLayoutSubviews()
		//nowPlayingCollectionView.reloadData()
		nowPlayingButton.layer.addBorder(edge: .bottom, border: self.nowPlayingBorder , color: .black, thickness: 2.0)
		upcomingButton.layer.addBorder(edge: .bottom, border: self.upcomingBorder , color: .black, thickness: 2.0)
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		nowPlayingCollectionView.collectionViewLayout.invalidateLayout()
		nowPlayingCollectionView.reloadData()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
    
    // MARK: Search
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarView?.backgroundColor = .clear
        searchBarView.isToggledOn = false
        self.view.endEditing(true)
    }
    
    @IBAction func searchButtonTouched(_ sender: UIButton) {
        searchBarView.isToggledOn = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBarView.isToggledOn = false
    }
    
    // MARK: Collection View Layout
    // DO NOT TOUCH
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if (collectionView == alphabetCollectionView) {
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                return CGSize(width: 40.2, height: alphabetCollectionView.frame.height)
            case .phone:
                return CGSize(width: 29.39, height: alphabetCollectionView.frame.height)
            default:
                return CGSize(width: 29.39, height: alphabetCollectionView.frame.height)
            }
        }
        else{
            
            return posterSize
            
        }
    
    
    }

//    func posterHasBeenTapped(_ cell: UICollectionViewCell, posterImage: UIImageView) {
//        
//        if let index = nowPlayingCollectionView.indexPath(for: cell){
//    
//            self.movieForSegue = isNowPlayingCurrentContent ? viewModel.nowPlayingMovies[index.row] : viewModel.upcomingMovies[index.row]
//            performSegue(withIdentifier: "nowPlayingToDetails", sender: nil)
//            
//        }
//        
//        
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if segue.identifier == "nowPlayingToDetails"{
         
            let mdvc : MovieDetailsViewController = segue.destination as! MovieDetailsViewController
            
            if let movie = movieForSegue{
            
                mdvc.movie = movie
            
            }
        
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath)
//		print(movieForSegue ?? nil)
//		print(NowPlayingViewModel.)
        self.movieForSegue = isNowPlayingCurrentContent ? viewModel.nowPlayingMovies[indexPath.item] : viewModel.upcomingMovies[indexPath.item]
        performSegue(withIdentifier: "nowPlayingToDetails", sender: nil)
        
    }
    
}
