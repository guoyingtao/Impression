//
//  FilterCollectionViewModel.swift
//  Chameleon
//
//  Created by Echo on 11/18/18.
//

import Foundation

struct FilterCollectionViewModel {
    var filters: [FilterProtocal] {
        get {
            return FilterManager.shared.filters
        }
    }
    
    func createDefaultFilters() {
        FilterManager.shared.register(filter: Filter1977Theme())
        FilterManager.shared.register(filter: NashvilleFilter())
    }
}
