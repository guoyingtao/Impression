//
//  OriginalFilter.swift
//  Impression
//
//  Created by Echo on 11/20/18.
//

import Foundation

struct OriginalFiler: FilterProtocol {
    var distinctName: String = "Original"
    
    var localizableNames: [LocaleLanguageCode : String] = [.English: "Original", .SimplifiedChinese: "原图"]
    
    func process(image: UIImage) -> UIImage? {
        return image
    }
}
