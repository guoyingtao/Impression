//
//  FilterCollectionViewCell.swift
//  Chameleon
//
//  Created by Echo on 11/20/18.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView?
    var titleLabel: UILabel?

    override func prepareForReuse() {
        imageView?.removeFromSuperview()
        titleLabel?.removeFromSuperview()
    }
    
    func setup(image: UIImage, title: String) {
        print(image.size)
        print(image.scale)
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 20))
        imageView?.contentMode = .scaleAspectFit
        imageView?.image = image
                
        titleLabel = UILabel(frame: CGRect(x: 0, y: imageView!.frame.maxY, width: frame.width, height: 20))
        titleLabel?.textAlignment = .center
        titleLabel?.text = title
        
        addSubview(imageView!)
        addSubview(titleLabel!)
    }
}
