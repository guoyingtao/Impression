//
//  CollectionDataSource.swift
//  Chameleon
//
//  Created by Echo on 11/18/18.
//

import UIKit

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
        
        cellConfigurator(model, cell)
        
        return cell
    }
}

extension CollectionDataSource where Model == (filter: FilterProtocal, image: UIImage) {
    static func make(for imageProcessors: [(FilterProtocal, UIImage)],
                     reuseIdentifier: String = "FilterCell") -> CollectionDataSource {
        return CollectionDataSource (
            models: imageProcessors,
            reuseIdentifier: reuseIdentifier
        ) { (imageProcessor, cell) in
            cell.backgroundColor = UIColor.white
            
            guard let cell = cell as? FilterCollectionViewCell else {
                return
            }

            guard let image = imageProcessor.filter.process(image: imageProcessor.image) else { return }
            cell.setup(image: image, title: imageProcessor.filter.name)
        }
    }
}
