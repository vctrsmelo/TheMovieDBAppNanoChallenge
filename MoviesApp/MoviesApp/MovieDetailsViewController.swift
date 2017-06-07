//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var selection: String = "videos"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor.clear
        tableView.layer.shadowColor = UIColor.darkGray.cgColor
        tableView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        tableView.layer.shadowOpacity = 0.95
        tableView.layer.shadowRadius = 6.0
        
        navigationController?.isNavigationBarHidden = true
        UIApplication.shared.statusBarView?.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 113
        case 1:
            return 237
        case 2:
            return 132
        case 3:
            return 63
        case 4:
            return 268
        case 5:
            return 258
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            cell.backgroundView?.backgroundColor = UIColor.white.withAlphaComponent(0)
            cell.backgroundColor = UIColor.white.withAlphaComponent(0)
            return cell
            
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: "mainInformationsCell") as! MainInformationsTableViewCell
            
        case 2:
            return tableView.dequeueReusableCell(withIdentifier: "overviewCell") as! OverviewTableViewCell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectionCell") as! SelectionTableViewCell
            cell.root = self
            return cell
            
        case 4:
            if selection == "videos" {
                return tableView.dequeueReusableCell(withIdentifier: "videosCell") as! VideosTableViewCell
            } else {
                return tableView.dequeueReusableCell(withIdentifier: "castingCell") as! CastingTableViewCell
            }
            
        case 5:
            return tableView.dequeueReusableCell(withIdentifier: "recommendationsCell") as! RecommendationsTableViewCell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "mainInformationsCell") as! MainInformationsTableViewCell
        }
    }
}
