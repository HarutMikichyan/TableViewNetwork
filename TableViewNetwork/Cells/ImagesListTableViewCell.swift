//
//  ImagesListTableViewCell.swift
//  TableViewNetwork
//
//  Created by Harut Mikichyan on 10/25/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import UIKit

class ImagesListTableViewCell: UITableViewCell {
    static let id = "ImagesListTableViewCell"
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var imageID: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImage.image = nil
    }
}
