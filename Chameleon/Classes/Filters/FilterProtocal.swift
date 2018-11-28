//
//  FilterProtocal.swift
//  Chameleon
//
//  Created by Echo on 11/16/18.
//

import UIKit

public protocol FilterProtocal {
    var distinctName: String { get set }
    var localizableNames: [String: String] { get set }
    func process(image: UIImage) -> UIImage?
}

extension FilterProtocal {
    func getDisplayName(byLocale locale: String = "en") -> String {
        if let name = localizableNames[locale] {
            return name
        }
        
        return distinctName
    }
}
