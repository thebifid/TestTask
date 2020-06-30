//
//  ResultImageCell.swift
//  TestTask
//
//  Created by Vasiliy Matveev on 30.06.2020.
//  Copyright © 2020 Vasiliy Matveev. All rights reserved.
//

import UIKit
import SDWebImage

class ResultImageCell: UICollectionViewCell {
    
    var image: Image! {
        didSet {
            imageView.sd_setImage(with: URL(string: image.original ?? ""))
        }
    }
    
    let imageView = UIImageView(cornerRadius: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.borderWidth = 0.5
        
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
