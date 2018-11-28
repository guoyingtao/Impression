//
//  FilterCollectionViewCell.swift
//  Impression
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
        backgroundColor = .black
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.width))
        imageView?.contentMode = .scaleAspectFill
        imageView?.image = image
        imageView?.clipsToBounds = true
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: imageView!.frame.maxY, width: frame.width, height: frame.height - imageView!.frame.height))
        titleLabel?.textAlignment = .center
        titleLabel?.text = title
        titleLabel?.textColor = .lightGray
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = .byWordWrapping
        
        addSubview(imageView!)
        addSubview(titleLabel!)
    }
    
    func setFocus() {
        imageView?.layer.borderWidth = 4
        imageView?.layer.borderColor = UIColor.blue.cgColor
        titleLabel?.textColor = .blue
    }
    
    func removeFocus() {
        imageView?.layer.borderWidth = 0
        imageView?.layer.borderColor = UIColor.clear.cgColor
        titleLabel?.textColor = .lightGray
    }
}
