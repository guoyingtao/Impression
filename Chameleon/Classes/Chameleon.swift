//
//  Chameleon.swift
//  Chameleon
//
//  Created by Echo on 11/16/18.
//

import Foundation

let filterThumbnailSize = CGSize(width: 120, height: 120)

func createDefaultFilters() {
    FilterManager.shared.register(filter: Filter1977Theme())
    FilterManager.shared.register(filter: NashvilleFilter())
}

public func createFilterViewController(image: UIImage) -> FilterViewController {
    createDefaultFilters()
    return FilterViewController(image: image)
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

