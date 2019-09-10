//
//  FilterCollectionViewModel.swift
//  Impression
//
//  Created by Echo on 11/18/18.
//

import Foundation

struct FilterCollectionViewModel {
    
    var filters: [FilterProtocol] {
        get {
            return FilterManager.shared.filters
        }
    }
}
