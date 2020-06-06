//
//  GalleryCell.swift
//  GoogleGallery
//
//  Created by Andrea Di Francia on 01/06/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import Foundation
import UIKit

class GalleryCell: UICollectionViewCell {
    
    private var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/4).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/4).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func setup() {
        layer.cornerRadius  = 5
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    func configure(image: UIImage) {
        imageView.image = image
    }
}
