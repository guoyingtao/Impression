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
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFocus), name: .cellBeingSelected, object: nil)
        
    }
    
    @objc func handleFocus(_ notification: Notification) {
        guard let obj = notification.object as? UICollectionViewCell else {
            return
        }
        
        if obj !== self {
            self.removeFocus()
        }
    }
    
    func readyForSelect() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(forName: .selectDefaultCell, object: nil, queue: nil) {[weak self] _ in
            self?.setFocus()
        }
    }
    
    func setFocus() {
        imageView?.layer.borderWidth = 4
        imageView?.layer.borderColor = UIColor.blue.cgColor
        titleLabel?.textColor = .blue
        
        NotificationCenter.default.post(name: .cellBeingSelected, object: self)
    }
    
    func removeFocus() {
        imageView?.layer.borderWidth = 0
        imageView?.layer.borderColor = UIColor.clear.cgColor
        titleLabel?.textColor = .lightGray
    }
    
    func update(_ image: UIImage) {
        imageView?.image = image
    }
}

extension Notification.Name {
    static var cellBeingSelected: Notification.Name {
        return .init(rawValue: "Impression.cellBeingSelected")
    }
    
    static var selectDefaultCell: Notification.Name {
        return .init(rawValue: "Impression.selectDefaultCell")
    }
}
