//
//  ImageManager.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/17/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

final class ImageManager {
    
    // Download image and save it in cache
    
    func imageDownloader(urlString: String, imageView: UIImageView) {
                
        guard let url = URL(string: urlString) else { return }
        let placeholderImage = UIImage(named: "imgholdr-vertical")
        
        imageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
    }
}
