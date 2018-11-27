//
//  NashvilleFilter.swift
//  Chameleon
//
//  Created by Echo on 11/18/18.
//

import Foundation

public struct NashvilleFilter: FilterProtocal {
    public var name: String = "Nashville"
    
    public var localizableNames: [String : String] = [:]
    
    public init() {}
    
    public func process(image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        
        let ciImage = CIImage(cgImage: cgImage)

        let backgroundImage = ImageHelper.getColorImage(red: 247, green: 176, blue: 153, alpha: Int(255 * 0.56), rect: ciImage.extent)
        let backgroundImage2 = ImageHelper.getColorImage(red: 0, green: 70, blue: 150, alpha: Int(255 * 0.4), rect: ciImage.extent)
        let newCiImage = ciImage
            .applyingFilter("CIDarkenBlendMode", parameters: [
                "inputBackgroundImage": backgroundImage,
                ])
            .applyingFilter("CISepiaTone", parameters: [
                "inputIntensity": 0.2,
                ])
            .applyingFilter("CIColorControls", parameters: [
                "inputSaturation": 1.2,
                "inputBrightness": 0.05,
                "inputContrast": 1.1,
                ])
            .applyingFilter("CILightenBlendMode", parameters: [
                "inputBackgroundImage": backgroundImage2,
                ])
        
        return ImageHelper.getImage(fromCIImage: newCiImage)
    }
}
