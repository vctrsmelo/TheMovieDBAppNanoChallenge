//
//  OverviewTableViewCell.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 05/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var movieOverview: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieOverview.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
