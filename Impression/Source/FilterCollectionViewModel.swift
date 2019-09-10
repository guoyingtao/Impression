//
//  FilterCollectionViewModel.swift
//  Impression
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
}
