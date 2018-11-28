//
//  OriginalFilter.swift
//  Impression
//
//  Created by Echo on 11/20/18.
//

import Foundation

struct OriginalFiler: FilterProtocal {
    var distinctName: String = "Original"
    
    var localizableNames: [String : String] = [LocaleLanguageCode.English.rawValue: "Original", LocaleLanguageCode.SimplifiedChinese.rawValue: "原图"]
    
    func process(image: UIImage) -> UIImage? {
        return image
    }
}
