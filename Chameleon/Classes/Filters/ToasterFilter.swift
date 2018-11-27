//
//  ToasterFilter.swift
//  Chameleon
//
//  Created by Echo on 11/18/18.
//

import Foundation

public struct ToasterFilter: FilterProtocal {
    public var name: String = "Toaster"
    
    public var localizableNames: [String : String] = [:]
    
    public init() {}
    
    public func process(image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        
        let ciImage = CIImage(cgImage: cgImage)
        let width = ciImage.extent.width
        let height = ciImage.extent.height
        let centerWidth = width / 2.0
        let centerHeight = height / 2.0
        let radius0 = min(width / 4.0, height / 4.0)
        let radius1 = min(width / 1.5, height / 1.5)
        
        let color0 = ImageHelper.getColor(red: 128, green: 78, blue: 15, alpha: 255)
        let color1 = ImageHelper.getColor(red: 79, green: 0, blue: 79, alpha: 255)
        let circle = CIFilter(name: "CIRadialGradient", parameters: [
            "inputCenter": CIVector(x: centerWidth, y: centerHeight),
            "inputRadius0": radius0,
            "inputRadius1": radius1,
            "inputColor0": color0,
            "inputColor1": color1,
            ])?.outputImage?.cropped(to: ciImage.extent)
        
        let newCiImage = ciImage
            .applyingFilter("CIColorControls", parameters: [
                "inputSaturation": 1.0,
                "inputBrightness": 0.01,
                "inputContrast": 1.1,
                ])
            .applyingFilter("CIScreenBlendMode", parameters: [
                "inputBackgroundImage": circle!,
                ])
        
        return ImageHelper.getImage(fromCIImage: newCiImage)
    }
}
