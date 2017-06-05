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
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (tableView.cellForRow(at: indexPath) as? MainInformationsTableViewCell) != nil {
            return 237
        } else if let currentCell = tableView.cellForRow(at: indexPath) as? MainInformationsTableViewCell {
            return 72 + currentCell
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //if indexPath == 0 {
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "mainInformationsCell") as! MainInformationsTableViewCell
        //}
        
        
        return cell
    }
}
