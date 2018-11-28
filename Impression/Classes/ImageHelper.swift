//
//  ImageHelper.swift
//  Impression
//
//  Created by Echo on 11/16/18.
//

import Foundation

struct ImageHelper {
    static func getColor(red: Int, green: Int, blue: Int, alpha: Int = 255) -> CIColor {
        return CIColor(red: CGFloat(Double(red) / 255.0),
                       green: CGFloat(Double(green) / 255.0),
                       blue: CGFloat(Double(blue) / 255.0),
                       alpha: CGFloat(Double(alpha) / 255.0))
    }
    
    static func getColorImage(red: Int, green: Int, blue: Int, alpha: Int = 255, rect: CGRect) -> CIImage {
        let color = getColor(red: red, green: green, blue: blue, alpha: alpha)
        return CIImage(color: color).cropped(to: rect)
    }
    
    static func getImage(fromCIImage ciImage: CIImage, ciContext: CIContext? = nil) -> UIImage? {
        var context = ciContext
        
        if context == nil {
            context = FilterManager.shared.ciContext
        }
        
        if context == nil {
            context = CIContext()
        }
        
        guard let cgImage = context?.createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}
