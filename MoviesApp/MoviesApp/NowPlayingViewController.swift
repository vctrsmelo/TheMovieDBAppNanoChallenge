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
    private var nowPlayingMovies : [Movie] = []
    
    private let posterSize = CGSize(width: 270, height: 400)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        
        let countryCode = (Locale.current.regionCode != nil) ? (Locale.current.regionCode!) : "US"
        
        TmdbAPIAccess.getNowPlayingMovies(countryCode: countryCode){(movies) in
         
            print("veio aqui")
            print(movies)
            self.nowPlayingMovies.append(contentsOf: movies)
            self.nowPlayingCollectionView.reloadData()
            self.nowPlayingCollectionView.setNeedsLayout()
            
        }
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 53, 0, 53)
        layout.minimumInteritemSpacing = 21
        layout.minimumLineSpacing = 21
        layout.scrollDirection = .horizontal
        layout.itemSize = posterSize
        
        nowPlayingCollectionView.collectionViewLayout = layout
        
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
        
        if(indexPath.row == 0){
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }
        
        var frame = cell.frame
        
        frame.size.width = posterSize.width
        frame.size.height = posterSize.height
        
        cell.frame = frame
        cell.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 10)
    
        cell.posterImageView.image = nowPlayingMovies[indexPath.row].poster
        
        return cell
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        for cell in nowPlayingCollectionView.visibleCells{
            
            if let nowPlayingCell = cell as? NowPlayingMovieCell{
                
                let cellFrame = nowPlayingCollectionView.convert(nowPlayingCell.frame, to: nowPlayingCollectionView.superview)
                
                nowPlayingCell.updateSize(cellFrame: cellFrame, container: nowPlayingCollectionView.frame)

            }
            
        }
        
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
