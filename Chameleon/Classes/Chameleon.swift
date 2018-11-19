//
//  Chameleon.swift
//  Chameleon
//
//  Created by Echo on 11/16/18.
//

import Foundation

let filterThumbnailSize = CGSize(width: 60, height: 60)


public func createFilterViewController(image: UIImage) -> FilterViewController {
    return FilterViewController(image: image)
}

