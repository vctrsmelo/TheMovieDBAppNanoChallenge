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

class NowPlayingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    private var collectionLayout : UICollectionViewFlowLayout!
    
    @IBOutlet weak var alphabetCollectionView: UICollectionView!
    private var currentSelectedAlphabetIndex : IndexPath?
    private var currentSelectedMovie: Movie?

    private var viewModel : NowPlayingViewModel!
    
    private let posterSize = CGSize(width: 215, height: 322)
    private var posterOriginY : CGFloat?
    
    @IBOutlet weak var nowPlayingButton: UIButton!
    private var nowPlayingBorder = CALayer()
    
    @IBOutlet weak var upcomingButton: UIButton!
    private var upcomingBorder = CALayer()
    
    private var nowPlayingIsCurrentContent = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        
        alphabetCollectionView.delegate = self
        alphabetCollectionView.dataSource = self
        
        let countryCode = (Locale.current.regionCode != nil) ? (Locale.current.regionCode!) : "US"
        
        viewModel = NowPlayingViewModel(view: self, isNowPlayingList: true, countryCode: countryCode)
        
        self.alphabetCollectionView.reloadData()
        self.alphabetCollectionView.setNeedsLayout()
        
        nowPlayingButton.layer.addBorder(edge: .bottom, border: self.nowPlayingBorder , color: .black, thickness: 2.0)
        upcomingButton.layer.addBorder(edge: .bottom, border: self.upcomingBorder , color: .black, thickness: 2.0)
        upcomingBorder.isHidden = true
        
        collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.sectionInset = UIEdgeInsetsMake(-10, 53, 0, 53)
        collectionLayout.minimumInteritemSpacing = 51
        collectionLayout.minimumLineSpacing = 51
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = posterSize
        
        nowPlayingCollectionView.collectionViewLayout = collectionLayout
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == nowPlayingCollectionView) {

            return viewModel.nowPlayingMovies.count
            
        } else {
            return viewModel.alphabet.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == nowPlayingCollectionView){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingMovieCell", for: indexPath) as! NowPlayingMovieCell
            
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
                
                currentSelectedMovie = viewModel.nowPlayingMovies[indexPath.row]
                alphabetCollectionView.reloadData()
            }
            
            
            currentSelectedMovie = viewModel.nowPlayingMovies[indexPath.row]
            
            //rounded corners
            cell.posterImageView.image = viewModel.nowPlayingMovies[indexPath.row].poster
            cell.posterImageView.layer.masksToBounds = true
            cell.posterImageView.layer.cornerRadius = 4

            //shadow
            cell.adjustShadow()
            return cell
            
        }else{ //alphabet collection view
            
            
            let alphabetCell = collectionView.dequeueReusableCell(withReuseIdentifier: "letterCell", for: indexPath) as! WatchlistAlphabetCollectionViewCell
            alphabetCell.letterLabel.text = String(viewModel.alphabet[indexPath.row])
            
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

        for cell in nowPlayingCollectionView.visibleCells{
            
            if let nowPlayingCell = cell as? NowPlayingMovieCell{
                
                let cellFrame = nowPlayingCollectionView.convert(nowPlayingCell.frame, to: nowPlayingCollectionView.superview)
                nowPlayingCell.updateSize(cellFrame: cellFrame, container: nowPlayingCollectionView.frame)
                
                
                if(nowPlayingCell.getFeaturedPerentage() > 50){
                        
                
                    if let movieIndex = nowPlayingCollectionView.indexPath(for: nowPlayingCell) {
                        
                        currentSelectedMovie = viewModel.nowPlayingMovies[movieIndex.row]
                        alphabetCollectionView.reloadData()

                        alphabetCollectionView.scrollToItem(at: currentSelectedAlphabetIndex!, at: UICollectionViewScrollPosition.right, animated: false)

                        
                    }

                }
                
                //shadow adjustment
                nowPlayingCell.adjustShadow()
                
            }
            
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }

    @IBAction func nowPlayingButtonTouched(_ sender: UIButton) {
        
        if nowPlayingIsCurrentContent { return }
        
        upcomingBorder.isHidden = true
        nowPlayingBorder.isHidden = false
        
        nowPlayingIsCurrentContent = true

    }
    
    
    @IBAction func upcomingButtonTouched(_ sender: UIButton) {

        if !nowPlayingIsCurrentContent { return }
        
        nowPlayingBorder.isHidden = true
        upcomingBorder.isHidden = false
        
        let countryCode = (Locale.current.regionCode != nil) ? (Locale.current.regionCode!) : "US"
        viewModel = NowPlayingViewModel(view: self, isNowPlayingList: false, countryCode: countryCode)
        self.nowPlayingCollectionView.reloadData()
        
        nowPlayingIsCurrentContent = false
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

}
