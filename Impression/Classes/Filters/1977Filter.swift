//
//  1977Filter.swift
//  Impression
//
//  Created by Echo on 11/16/18.
//

import Foundation

public struct Filter1977Theme: FilterProtocal {
    public var distinctName: String = "1977"
    
    public var localizableNames: [String : String] = [LocaleLanguageCode.English.rawValue: "1977", LocaleLanguageCode.SimplifiedChinese.rawValue: "1977年"]
    
    public func process(image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        
        let ciImage = CIImage(cgImage: cgImage)
        let filterImage = ImageHelper.getColorImage(red: 243, green: 106, blue: 188, alpha: Int(255 * 0.1), rect: ciImage.extent)
        let backgroundImage = ciImage
            .applyingFilter("CIColorControls", parameters: [
                "inputSaturation": 1.3,
                "inputBrightness": 0.1,
                "inputContrast": 1.05,
                ])
            .applyingFilter("CIHueAdjust", parameters: [
                "inputAngle": 0.3,
                ])
        let newCiImage = filterImage
            .applyingFilter("CIScreenBlendMode", parameters: [
                "inputBackgroundImage": backgroundImage,
                ])
            .applyingFilter("CIToneCurve", parameters: [
                "inputPoint0": CIVector(x: 0, y: 0),
                "inputPoint1": CIVector(x: 0.25, y: 0.20),
                "inputPoint2": CIVector(x: 0.5, y: 0.5),
                "inputPoint3": CIVector(x: 0.75, y: 0.80),
                "inputPoint4": CIVector(x: 1, y: 1),
                ])
        
        return ImageHelper.getImage(fromCIImage: newCiImage)
    }
}
