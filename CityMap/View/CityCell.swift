//
//  CityCell.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/6/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import UIKit
import AlamofireImage

// MARK: - Constants

private enum Constants {
    static let imageHolder = "imgholdr-vertical"
}

class CityCell: UICollectionViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var city: City? {
        didSet {
            update()
        }
    }
    
    // Update cell's properties.
    
    private func update() {
        nameLabel.text = city?.title
        imageView.af_setImage(withURL: (city?.url)!, placeholderImage: UIImage(named: Constants.imageHolder))
    }
    
    // Clean values of properties when the cell is reused.
    
    override func prepareForReuse() {
        nameLabel.text = nil
        imageView.af_cancelImageRequest()
    }
}
