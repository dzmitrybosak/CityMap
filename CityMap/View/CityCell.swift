//
//  CityCell.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/6/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import UIKit

class CityCell: UICollectionViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // Clean values of properties when the cell is reused.
    
    override func prepareForReuse() {
        nameLabel.text = nil
        imageView.image = UIImage(named: "imgholdr-vertical")
        super.prepareForReuse()
    }
}
