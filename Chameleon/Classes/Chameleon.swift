//
//  Chameleon.swift
//  Chameleon
//
//  Created by Echo on 11/16/18.
//

import Foundation

let filterThumbnailSize = CGSize(width: 120, height: 120)

public func createFilterViewController(image: UIImage) -> FilterViewController {
    return FilterViewController(image: image)
}

