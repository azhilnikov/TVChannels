//
//  TVChannelsTableViewController.swift
//  TVChannels
//
//  Created by Alexey on 3/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class TVChannelsTableViewController: UITableViewController {

    fileprivate let dataProvider = TVChannelsDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        dataProvider.fetch() { [weak self] (result) in
            DispatchQueue.main.async {
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tvProgramsTableViewController = segue.destination as? TVProgramsTableViewController,
            let channelId = sender as? Int {
            tvProgramsTableViewController.channelId = channelId
        }
    }
}

extension TVChannelsTableViewController {
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVChannelCell", for: indexPath)
        cell.textLabel?.text = dataProvider[indexPath.row]?.name
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let channelId = dataProvider[indexPath.row]?.channelId {
            performSegue(withIdentifier: "ShowTVPrograms", sender: channelId)
        }
    }
}
