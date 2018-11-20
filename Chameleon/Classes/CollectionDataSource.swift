//
//  CollectionDataSource.swift
//  Chameleon
//
//  Created by Echo on 11/18/18.
//

import UIKit

class CollectionDataSource<Model>: NSObject, UICollectionViewDataSource {
    typealias CellConfigurator = (Model, UICollectionViewCell, IndexPath) -> Void
    
    var models: [Model]
    
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    init(models: [Model],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(models.count)
        return models.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        )
        
        cellConfigurator(model, cell, indexPath)
        
        return cell
    }
}
