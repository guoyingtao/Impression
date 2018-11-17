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
