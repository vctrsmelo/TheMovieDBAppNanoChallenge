//
//  NowPlayingMovieCell.swift
//  MoviesApp
//
//  Created by Victor S Melo on 05/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class NowPlayingMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!

    private let originalSize = CGSize(width: 270, height: 400)
    
    public func updateSize(cellFrame: CGRect, container: CGRect){
        
        let containerXCenter : Double = Double(container.origin.x + container.width/2)
        print("containerXCenter: \(containerXCenter)")
        
        let cellXCenter : Double = Double(cellFrame.origin.x + cellFrame.width/2)
        
        let distance : Double = abs(containerXCenter - cellXCenter)
        

        let multFactor : Double = (1 - (distance/100.0))*100
        
        print(multFactor)
        
        let increasedHeight = Double((multFactor*15)/100)
        let newHeight : Double = Double(originalSize.height)+increasedHeight
        let newWidth : Double = Double(originalSize.width/originalSize.height) * newHeight
        
        let increasedWidth: Double = Double(originalSize.width) - newWidth
        
        self.frame.size.width = CGFloat(newWidth)
        self.frame.size.height = CGFloat(newHeight)
        
//        let newX = cellFrame.origin.x - CGFloat(increasedWidth/2)
//        let newY = cellFrame.origin.y - CGFloat(increasedHeight/2)
//        
//        self.frame = CGRect(x: newX, y: newY, width: CGFloat(newWidth), height: CGFloat(newHeight))
        
    }
}
