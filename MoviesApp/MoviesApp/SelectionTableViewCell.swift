//
//  SelectionTableViewCell.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 05/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {
    
    weak var root: MovieDetailsViewController!

    @IBOutlet weak var videosButton: UIButton!
    @IBOutlet weak var castingButton: UIButton!
    
    @IBOutlet weak var videosSelectedLabel: UIView!
    @IBOutlet weak var castingSelectedLabel: UIView!
    
    override func awakeFromNib() {
        castingButton.titleLabel?.textColor = UIColor.white
        super.awakeFromNib()
        
        let device = UIDevice.current.model
        if device.contains("iPhone") {
            videosButton.imageView?.frame.size = CGSize(width: 11, height: 16)
            videosButton.imageView?.clipsToBounds = true
            castingButton.imageView?.frame.size = CGSize(width: 12, height: 16)
            castingButton.imageView?.clipsToBounds = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func videosPressed(_ sender: UIButton) {
        root.selection = "videos"
        
        videosButton.setTitleColor(videosSelectedLabel.backgroundColor, for: UIControlState.normal)
        videosButton.setImage(UIImage(named: "Icon_Video_Select"), for: UIControlState.normal)
        videosSelectedLabel.isHidden = false
        
        castingButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        castingButton.setImage(UIImage(named: "Icon_Casting"), for: UIControlState.normal)
        castingSelectedLabel.isHidden = true
        
        root.tableView.reloadData()
    }
    
    @IBAction func castingPressed(_ sender: UIButton) {
        root.selection = "casting"
        
        videosButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        videosButton.setImage(UIImage(named: "Icon_Video"), for: UIControlState.normal)
        videosSelectedLabel.isHidden = true
        
        castingButton.setTitleColor(castingSelectedLabel.backgroundColor, for: UIControlState.normal)
        castingButton.setImage(UIImage(named: "Icon_Castibg_Select"), for: UIControlState.normal)
        castingSelectedLabel.isHidden = false
        
        root.tableView.reloadData()
    }
}
