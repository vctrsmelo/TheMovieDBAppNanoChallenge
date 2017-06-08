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

class NowPlayingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    private var collectionLayout : UICollectionViewFlowLayout!
    
    @IBOutlet weak var alphabetCollectionView: UICollectionView!
    
    
    private var nowPlayingMovies : [Movie] = []
    
    private let posterSize = CGSize(width: 215, height: 322)
    
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
        
        TmdbAPIAccess.getNowPlayingMovies(countryCode: countryCode){(movies) in
         
            print(movies)
            self.nowPlayingMovies.append(contentsOf: movies)
            self.nowPlayingCollectionView.reloadData()
            self.nowPlayingCollectionView.setNeedsLayout()
            
            self.alphabetCollectionView.reloadData()
            self.alphabetCollectionView.setNeedsLayout()
            
        }
        
        nowPlayingButton.layer.addBorder(edge: .bottom, border: self.nowPlayingBorder , color: .black, thickness: 2.0)
        upcomingButton.layer.addBorder(edge: .bottom, border: self.upcomingBorder , color: .black, thickness: 2.0)
        upcomingBorder.isHidden = true
        
        collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.sectionInset = UIEdgeInsetsMake(-20, 53, 0, 53)
        collectionLayout.minimumInteritemSpacing = 51
        collectionLayout.minimumLineSpacing = 51
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = posterSize
        
        nowPlayingCollectionView.collectionViewLayout = collectionLayout
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return nowPlayingMovies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == nowPlayingCollectionView){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingMovieCell", for: indexPath) as! NowPlayingMovieCell
            
            
    //        if(indexPath.row == 0){
    //            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    //            
    //        }
            
            var frame = cell.frame
            
            frame.size.width = posterSize.width
            frame.size.height = posterSize.height
            
            cell.frame = frame
        
            let cellFrame = nowPlayingCollectionView.convert(cell.frame, to: nowPlayingCollectionView.superview)
            cell.updateSize(cellFrame: cellFrame, container: self.nowPlayingCollectionView.frame)
            
            //rounded corners
            cell.posterImageView.image = nowPlayingMovies[indexPath.row].poster
            cell.posterImageView.layer.masksToBounds = true
            cell.posterImageView.layer.cornerRadius = 4

            //shadow
            cell.adjustShadow()
            return cell
            
        }else{ //alphabet collection view
            
            let cell: WatchlistAlphabetCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "letterCell", for: indexPath) as! WatchlistAlphabetCollectionViewCell
            cell.letterLabel.text = String.init(describing: self.nowPlayingMovies[indexPath.row].title!.uppercased().characters.first!)
            
            
            return cell
            
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        for cell in nowPlayingCollectionView.visibleCells{
            
            if let nowPlayingCell = cell as? NowPlayingMovieCell{
                
                let cellFrame = nowPlayingCollectionView.convert(nowPlayingCell.frame, to: nowPlayingCollectionView.superview)
                nowPlayingCell.updateSize(cellFrame: cellFrame, container: nowPlayingCollectionView.frame)
                
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
        
        nowPlayingIsCurrentContent = false
    }

}
