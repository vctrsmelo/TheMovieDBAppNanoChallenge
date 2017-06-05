//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Marcelo Andrighetto Foltz on 01/06/17.
//  Copyright © 2017 Marcelo Andrighetto Foltz. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var contentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTableView.dataSource = self
        contentTableView.delegate = self
        
        contentTableView.backgroundColor = UIColor.clear
        contentTableView.layer.shadowColor = UIColor.darkGray.cgColor
        contentTableView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        contentTableView.layer.shadowOpacity = 0.95
        contentTableView.layer.shadowRadius = 6.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 237
        case 1:
            return 172
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return contentTableView.dequeueReusableCell(withIdentifier: "mainInformationsCell") as! MainInformationsTableViewCell
        case 1:
            return contentTableView.dequeueReusableCell(withIdentifier: "overviewCell") as! OverviewTableViewCell
        default:
            return contentTableView.dequeueReusableCell(withIdentifier: "mainInformationsCell") as! MainInformationsTableViewCell
        }
    }
}
