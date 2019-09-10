//
//  FilterProtocal.swift
//  Impression
//
//  Created by Echo on 11/16/18.
//

import UIKit

public protocol FilterProtocal {
    var distinctName: String { get set }
    var localizableNames: [LocaleLanguageCode: String] { get set }
    func process(image: UIImage) -> UIImage?
}

extension FilterProtocal {
    func getDisplayNameByLocale(_ locale: String = "en") -> String {
        guard let key = LocaleLanguageCode(rawValue: locale) else {
            return distinctName
        }
      
        if let name = localizableNames[key] {
            return name
        }
        
        return distinctName
    }
}
