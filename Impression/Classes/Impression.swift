//
//  Impression.swift
//  Impression
//
//  Created by Echo on 11/16/18.
//

import UIKit

let filterThumbnailSize = CGSize(width: 120, height: 150)

public enum LocaleLanguageCode: String {
    case English = "en"
    case SimplifiedChinese = "zh-Hans"
    case TraditionalChiniese = "zh-Hant"
    case Japanese = "ja"
    case French = "fa"
    case Spanish = "es"
    case German = "de"
    case Arabic = "ar"
    case Russia = "ru"
    case Korea = "ko"
    case Portuguese = "pt-PT"
}

func createDefaultFilters() {
    FilterManager.shared.register(filter: Filter1977Theme())
    FilterManager.shared.register(filter: NashvilleFilter())
}

public func createFilterViewController(image: UIImage, delegate: FilterViewControllerProtocal?, useDefaultFilters: Bool = true) -> UIViewController {
    if useDefaultFilters {
        createDefaultFilters()
    }
    
    let filterViewController = FilterViewController(image: image)
    filterViewController.delegate = delegate
    let navigationController = UINavigationController(rootViewController: filterViewController)
    return navigationController
}

public func createCustomFilterViewController(image: UIImage, delegate: FilterViewControllerProtocal?, useDefaultFilters: Bool = true) -> FilterViewController {
    if useDefaultFilters {
        createDefaultFilters()
    }
    
    let filterViewController = FilterViewController(image: image, mode: .customizable)
    filterViewController.delegate = delegate
    return filterViewController
}

public func removeAllFilters() {
    FilterManager.shared.removeAll()
}

public func addCustomFilters(filter: FilterProtocal) {
    FilterManager.shared.register(filter: filter)
}

public func addCustomFilters(filters: [FilterProtocal]) {
    filters.forEach {
        FilterManager.shared.register(filter: $0)
    }    
}

