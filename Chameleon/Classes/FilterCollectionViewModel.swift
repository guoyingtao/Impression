//
//  FilterCollectionViewModel.swift
//  Chameleon
//
//  Created by Echo on 11/18/18.
//

import Foundation

struct FilterCollectionViewModel {
    
    init() {
        createDefaultFilters()
    }
    
    var filters: [FilterProtocal] {
        get {
            return FilterManager.shared.filters
        }
    }
    
    func createDefaultFilters() {
        FilterManager.shared.register(filter: OriginalFiler())
        FilterManager.shared.register(filter: Filter1977Theme())
        FilterManager.shared.register(filter: NashvilleFilter())
        FilterManager.shared.register(filter: Nashville1Filter())
        FilterManager.shared.register(filter: Nashville2Filter())
    }
}
