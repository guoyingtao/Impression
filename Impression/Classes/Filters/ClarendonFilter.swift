//
//  ClarendonFilter.swift
//  Impression
//
//  Created by Echo on 11/18/18.
//

import Foundation

public struct ClarendonFilter: FilterProtocal {
    public var distinctName: String = "Clarendon"
    
    public var localizableNames: [String : String] = [LocaleLanguageCode.English.rawValue: "Clarendon", LocaleLanguageCode.SimplifiedChinese.rawValue: "克拉伦登"]
    
    public init() {}
    
    public func process(image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        
        let ciImage = CIImage(cgImage: cgImage)
        
        let backgroundImage = ImageHelper.getColorImage(red: 127, green: 187, blue: 227, alpha: Int(255 * 0.2), rect: ciImage.extent)

        let newCiImage = ciImage
            .applyingFilter("CIOverlayBlendMode", parameters: [
            "inputBackgroundImage": backgroundImage,
            ])
            .applyingFilter("CIColorControls", parameters: [
                "inputSaturation": 1.35,
                "inputBrightness": 0.05,
                "inputContrast": 1.1,
                ])
        
        return ImageHelper.getImage(fromCIImage: newCiImage)
    }
}
