//
//  Extensions.swift
//  TVChannels
//
//  Created by Alexey on 4/7/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

extension DateFormatter {
    
    func convert(from stringDate: String) -> Date? {
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return self.date(from: stringDate)
    }
    
    func date(from: Date) -> String {
        self.dateFormat = "dd/MM/yyyy"
        return self.string(from: from)
    }
    
    func time(from: Date) -> String {
        self.dateFormat = "HH:mm"
        return self.string(from: from)
    }
}

extension UIViewController {
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
