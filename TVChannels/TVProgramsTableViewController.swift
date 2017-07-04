//
//  TVProgramsTableViewController.swift
//  TVChannels
//
//  Created by Alexey on 4/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit
import Kingfisher

class TVProgramsTableViewController: UITableViewController {
    
    var channelId: Int?
    
    fileprivate let dataProvider = TVProgramsDataProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 360
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if let channelId = self.channelId {
            navigationItem.title = "Channel \(channelId)"
            
            dataProvider.fetch(channelId) { [weak self] (result) in
                switch result {
                case .success:
                    self?.tableView.reloadData()
                    
                case .failure(let error as TVAPIError):
                    self?.showAlert(title: "Error", message: error.errorDescription)
                    
                default:
                    self?.showAlert(title: "Error", message: "Unknown error")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TVProgramsTableViewController {
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TVProgramCell", for: indexPath) as? TVProgramTableViewCell {
            let tvProgram = dataProvider[indexPath.row]
            cell.tvProgram = tvProgram
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVProgramCell", for: indexPath) as? TVProgramTableViewCell
        cell?.cancelImageDownloading()
    }
}
