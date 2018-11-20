//
//  FilterProtocal.swift
//  Chameleon
//
//  Created by Echo on 11/16/18.
//

import Foundation

public protocol FilterProtocal {
    var name: String { get set }
    var localizableNames: [String: String] { get set }
    func process(image: UIImage) -> UIImage?
}

extension FilterProtocal {
    func getImage(from ciImage: CIImage) -> UIImage? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}
