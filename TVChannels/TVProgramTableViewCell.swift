//
//  TVProgramTableViewCell.swift
//  TVChannels
//
//  Created by Alexey on 4/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class TVProgramTableViewCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateTimeLabel: UILabel!
    @IBOutlet private var programImageView: UIImageView!
    @IBOutlet private var synopsisLabel: UILabel!
    
    var tvProgram: TVProgram? {
        willSet {
            titleLabel?.text = newValue?.title
            synopsisLabel?.text = newValue?.synopsis
            
            if let stringDate = newValue?.startTime, let date = dateFormatter.convert(from: stringDate) {
                dateTimeLabel?.text = "\(dateFormatter.time(from: date)), \(dateFormatter.date(from: date))"
            }
            if let imageLink = newValue?.imageURL, let url = URL(string: imageLink) {
                programImageView?.kf.setImage(with: url)
            }
        }
    }
    
    func cancelImageDownloading() {
        programImageView?.kf.cancelDownloadTask()
    }
    
    private var dateFormatter = DateFormatter()
}
