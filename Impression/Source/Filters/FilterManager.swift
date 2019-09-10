//
//  FilterManager.swift
//  Impression
//
//  Created by Echo on 11/16/18.
//

import Foundation

class FilterManager {
    static var shared: FilterManager = FilterManager()
    
    private init() {
        ciContext = CIContext()
    }
    
    var filters: [FilterProtocol] = [OriginalFiler()]
    var ciContext: CIContext
    
    @discardableResult
    func register(filter: FilterProtocol) -> Bool {
        guard case .none = contains(filter: filter) else {
            return false
        }
        
        filters.append(filter)
        return true
    }
    
    func unregister(filter: FilterProtocol) {
        guard case .contains(let index) = contains(filter: filter) else {
            return
        }
            
        filters.remove(at: index)
    }
    
    func contains(filter: FilterProtocol) -> ContainsType {
        for i in 0..<filters.count {
            if filters[i].distinctName == filter.distinctName {
                return .contains(index: i)
            }
        }
        
        return .none
    }
    
    func removeAll() {
        filters.removeAll()
    }
}

extension FilterManager {
    enum ContainsType {
        case none
        case contains(index: Int)
    }
}
