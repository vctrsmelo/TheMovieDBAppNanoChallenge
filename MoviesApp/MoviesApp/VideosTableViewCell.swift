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

    let videosURL: [String] = ["https://youtu.be/5lGoQhFb4NM", "https://youtu.be/INLzqh7rZ-U"]
    
    @IBOutlet weak var videosCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        videosCollectionView.dataSource = self
        videosCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func videoSnapshot(filePathLocal: NSString) -> UIImage? {
        
        let vidURL = NSURL(fileURLWithPath:filePathLocal as String) as URL
        let asset = AVURLAsset(url: vidURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
        
        do {
            let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
            return UIImage(cgImage: imageRef)
        }
        catch _ as NSError
        {
            return nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videosURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = videosCollectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCollectionViewCell
        cell.playVideoButton.setImage(videoSnapshot(filePathLocal: videosURL[indexPath.item] as NSString),
                                      for: UIControlState.normal)
        return cell
    }
}
