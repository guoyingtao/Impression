//
//  HazeRemovalFilter.swift
//  Chameleon
//
//  Created by Echo on 11/27/18.
//

import Foundation

public struct HazeRemovalFilter: FilterProtocal {
    public var distinctName: String = "Haze Removal"
    
    public var localizableNames: [String : String] = [LocaleLanguageCode.English.rawValue: "Haze Removal", LocaleLanguageCode.SimplifiedChinese.rawValue: "消除朦胧"]
    
    public func process(image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        
        let ciImage = CIImage(cgImage: cgImage)
        
        return nil
    }
    
    
}
