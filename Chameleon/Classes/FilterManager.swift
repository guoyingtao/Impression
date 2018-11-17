//
//  FilterManager.swift
//  Chameleon
//
//  Created by Echo on 11/16/18.
//

import Foundation

class FilterManager {
    static var shared: FilterManager = FilterManager()
    
    private init() {}
    
    var filters: [FilterProtocal] = []
    
    func register(filter: FilterProtocal) {
        
    }
    
    func unregister(filter: FilterProtocal) {
        
    }
}
