//
//  NowPlayingViewController.swift
//  MoviesApp
//
//  Created by Victor S Melo on 05/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    private var collectionLayout : UICollectionViewFlowLayout!
    
    private var nowPlayingMovies : [Movie] = []
    
    private let posterSize = CGSize(width: 215, height: 322)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        
        let countryCode = (Locale.current.regionCode != nil) ? (Locale.current.regionCode!) : "US"
        
        TmdbAPIAccess.getNowPlayingMovies(countryCode: countryCode){(movies) in
         
            print(movies)
            self.nowPlayingMovies.append(contentsOf: movies)
            self.nowPlayingCollectionView.reloadData()
            self.nowPlayingCollectionView.setNeedsLayout()
            
        }
        
        
        collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.sectionInset = UIEdgeInsetsMake(0, 53, 0, 53)
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
        
        
        let cell: NowPlayingMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingMovieCell", for: indexPath) as! NowPlayingMovieCell
        
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
        adjustShadow(to: cell)
        
        return cell
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        for cell in nowPlayingCollectionView.visibleCells{
            
            if let nowPlayingCell = cell as? NowPlayingMovieCell{
                
                let cellFrame = nowPlayingCollectionView.convert(nowPlayingCell.frame, to: nowPlayingCollectionView.superview)
                nowPlayingCell.updateSize(cellFrame: cellFrame, container: nowPlayingCollectionView.frame)
                
                //shadow adjustment
                self.adjustShadow(to: nowPlayingCell)
            }
            
        }
        
    }
    
    private func adjustShadow(to cell: NowPlayingMovieCell){
        
        let ft = cell.getFeaturedPerentage()
        let defaultShadowRadius: CGFloat = 5
        var finalShadowRadius: CGFloat = 5
        
        if(ft != 0){
            
            finalShadowRadius = defaultShadowRadius * ft / (defaultShadowRadius*10)
            print("finalShadowRadius: \(finalShadowRadius)")
        }
        
        
        cell.clipsToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = finalShadowRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 4).cgPath

        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        print("terminou decelerating")
    
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
            print("terminou dragging")
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
