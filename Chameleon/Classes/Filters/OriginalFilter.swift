//
//  OriginalFilter.swift
//  Chameleon
//
//  Created by Echo on 11/20/18.
//

import Foundation

struct OriginalFiler: FilterProtocal {
    var name: String = "Original"
    
    var localizableNames: [String : String] = [:]
    
    func process(image: UIImage) -> UIImage? {
        return image
    }
}
