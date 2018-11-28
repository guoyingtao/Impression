//
//  HazeRemovalFilter.swift
//  Chameleon
//
//  Created by Echo on 11/27/18.
//

import Foundation

class HazeRemovalCIFilter: CIFilter {
    var inputImage: CIImage!
    var inputColor: CIColor! = CIColor(red: 0.7, green: 0.9, blue: 1.0)
    var inputDistance: Float! = 0.2
    var inputSlope: Float! = 0.0
    var hazeRemovalKernel: CIKernel!
    
    override init()
    {
        // check kernel has been already initialized
        let code: String = """
kernel vec4 myHazeRemovalKernel(
    sampler src,
    __color color,
    float distance,
    float slope)
{
    vec4 t;
    float d;

    d = destCoord().y * slope + distance;
    t = unpremultiply(sample(src, samplerCoord(src)));
    t = (t - d * color) / (1.0 - d);

    return premultiply(t);
}
"""
        self.hazeRemovalKernel = CIKernel(source: code)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var outputImage: CIImage?
    {
        guard let inputImage = self.inputImage,
            let hazeRemovalKernel = self.hazeRemovalKernel,
            let inputColor = self.inputColor,
            let inputDistance = self.inputDistance,
            let inputSlope = self.inputSlope
            else {
                return nil
        }
        let src: CISampler = CISampler(image: inputImage)
        return hazeRemovalKernel.apply(extent: inputImage.extent,
                                       roiCallback: { (index, rect) -> CGRect in
                                        return rect
        }, arguments: [
            src,
            inputColor,
            inputDistance,
            inputSlope,
            ])
    }
    
    override var attributes: [String : Any] {
        return [
            kCIAttributeFilterDisplayName: "Haze Removal Filter",
            "inputDistance": [
                kCIAttributeMin: 0.0,
                kCIAttributeMax: 1.0,
                kCIAttributeSliderMin: 0.0,
                kCIAttributeSliderMax: 0.7,
                kCIAttributeDefault: 0.2,
                kCIAttributeIdentity : 0.0,
                kCIAttributeType: kCIAttributeTypeScalar
            ],
            "inputSlope": [
                kCIAttributeSliderMin: -0.01,
                kCIAttributeSliderMax: 0.01,
                kCIAttributeDefault: 0.00,
                kCIAttributeIdentity: 0.00,
                kCIAttributeType: kCIAttributeTypeScalar
            ],
            kCIInputColorKey: [
                kCIAttributeDefault: CIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)
            ],
        ]
    }
}

public struct HazeRemovalFilter: FilterProtocal {
    public var distinctName: String = "Haze Removal"
    
    public var localizableNames: [String : String] = [LocaleLanguageCode.English.rawValue: "Haze Removal", LocaleLanguageCode.SimplifiedChinese.rawValue: "消除朦胧"]
    
    public init() {}
    
    public func process(image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        
        let ciImage = CIImage(cgImage: cgImage)
        
        let filter = HazeRemovalCIFilter()
        filter.inputImage = ciImage
        
        guard let outputImage = filter.outputImage else {
            return nil
        }
        
        return ImageHelper.getImage(fromCIImage: outputImage)
    }
    
}
