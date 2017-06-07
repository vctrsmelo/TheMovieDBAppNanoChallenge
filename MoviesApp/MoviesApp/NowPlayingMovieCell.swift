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

    private let heightIncreaseFactor : CGFloat = 80.0
    
    private let originalSize = CGSize(width: 215, height: 322)
    
    private var featuredPercentage: CGFloat?
    
    public func updateSize(cellFrame: CGRect, container: CGRect){
        
        let containerXCenter : CGFloat = container.origin.x + container.width/2

        let cellXCenter : CGFloat = cellFrame.origin.x + cellFrame.width/2
        
        let distance : CGFloat = abs(containerXCenter - cellXCenter)
        

        //entre 0 e 100, sendo 100 = maior tamanho e 0 = menor tamanho
        featuredPercentage = (1 - (distance/container.width))*100
        
        let newHeight = originalSize.height+(featuredPercentage!*heightIncreaseFactor)/100
        let newWidth = (originalSize.width/originalSize.height) * newHeight

        
        //size changes relating to current size
        let increasedHeight = abs(self.frame.height - newHeight)
        let increasedWidth = abs(self.frame.width - newWidth)
        
        
        //position changes relating to current position
        let newX = (self.frame.width < newWidth) ? self.frame.origin.x - increasedWidth/2 : self.frame.origin.x + increasedWidth/2
        let newY = (self.frame.height < newHeight) ? self.frame.origin.y - increasedHeight/2 : self.frame.origin.y + increasedHeight/2
        
        self.frame.size.width = CGFloat(newWidth)
        self.frame.size.height = CGFloat(newHeight)
        
        self.frame.origin.x = newX
        self.frame.origin.y = newY
        
    }
    
    func getFeaturedPerentage() -> CGFloat{
        
        if let feature = self.featuredPercentage {
            
            return feature
            
        }
        
        return 0.0
        
    }
}
