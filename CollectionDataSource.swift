//
//  CollectionDataSource.swift
//  Chameleon
//
//  Created by Echo on 11/18/18.
//

import Foundation

class CollectionDataSource<Model>: NSObject, UICollectionViewDataSource {
    typealias CellConfigurator = (Model, UICollectionViewCell) -> Void
    
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
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        )
        
        cellConfigurator(model, cell)
        
        return cell
    }
}

extension CollectionDataSource where Model == FilterProtocal {
    static func make(for fileters: [FilterProtocal],
                     reuseIdentifier: String = "message") -> CollectionDataSource {
        return CollectionDataSource (
            models: fileters,
            reuseIdentifier: reuseIdentifier
        ) { (message, cell) in
            // to do
        }
    }
}
