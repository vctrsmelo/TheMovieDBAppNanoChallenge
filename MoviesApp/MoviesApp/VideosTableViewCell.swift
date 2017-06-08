//
//  VideosTableViewCell.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 06/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit
import AVFoundation

class VideosTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    var videosURL: [String] = ["5lGoQhFb4NM", "INLzqh7rZ-U"]
    
    @IBOutlet weak var videosCellHeight: NSLayoutConstraint!
    @IBOutlet weak var videosCellTop: NSLayoutConstraint!
    
    @IBOutlet weak var videosCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        videosCollectionView.dataSource = self
        videosCollectionView.delegate = self
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.current.orientation == .portrait {
                videosCellHeight.constant   = 346
                videosCellTop.constant      = 84
            } else {
                videosCellHeight.constant   = 450
                videosCellTop.constant      = 109
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videosURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = videosCollectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCollectionViewCell
        let url = URL(string: "https://www.youtube.com/embed/\(videosURL[indexPath.item])")!
        cell.videoWebView.loadRequest(URLRequest(url: url))
        cell.videoWebView.scalesPageToFit = true
        cell.videoWebView.scrollView.isScrollEnabled = false
        return cell
    }
}
