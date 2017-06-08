//
//  OverviewTableViewCell.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 05/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var overviewLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var overviewLabelTop: NSLayoutConstraint!
    @IBOutlet weak var overviewLabelLeading: NSLayoutConstraint!
    @IBOutlet weak var overviewLabelTrailing: NSLayoutConstraint!
    @IBOutlet weak var movieOverviewTop: NSLayoutConstraint!
    @IBOutlet weak var movieOverviewBottom: NSLayoutConstraint!
    
    @IBOutlet weak var movieOverview: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieOverview.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.current.orientation == .portrait {
                overviewLabelHeight.constant    = 25
                overviewLabelTop.constant       = 42
                overviewLabelLeading.constant   = 42 // Leading de todas as views
                overviewLabelTrailing.constant  = 48 // Trailing ''
                movieOverviewTop.constant       = 30
                movieOverviewBottom.constant    = 40
            } else {
                overviewLabelHeight.constant    = 25
                overviewLabelTop.constant       = 50
                overviewLabelLeading.constant   = 57 // Leading de todas as views
                overviewLabelTrailing.constant  = 63 // Trailing de todas as views
                movieOverviewTop.constant       = 25
                movieOverviewBottom.constant    = 43
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
