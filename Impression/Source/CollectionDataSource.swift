//
//  CollectionDataSource.swift
//  Impression
//
//  Created by Echo on 11/18/18.
//

import UIKit

class CollectionDataSource<Model>: NSObject, UICollectionViewDataSource {
    typealias CellConfigurator = (Model, UICollectionViewCell, IndexPath, Int) -> Void
    
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
            ) as? FilterCollectionViewCell else {
                fatalError("Wrong cell.")
        }
        
        if indexPath.item == 0 {
            cell.readyForSelect()
        }
        
        if let filterCollectionView = collectionView as? FilterCollectionView {
            cellConfigurator(model, cell, indexPath, filterCollectionView.lastSelectedIndex)
        }
        
        return cell
    }
}

extension CollectionDataSource where Model == (filter: FilterProtocol, image: UIImage) {
    static func make(for imageProcessors: [(FilterProtocol, UIImage)],
                     reuseIdentifier: String = "FilterCell") -> CollectionDataSource {
        return CollectionDataSource (
            models: imageProcessors,
            reuseIdentifier: reuseIdentifier
        ) { (imageProcessor, cell, indexPath, lastSelectedIndex) in
            cell.backgroundColor = UIColor.white
            
            guard let cell = cell as? FilterCollectionViewCell else {
                return
            }
            
            func setupCell() {
                guard let image = imageProcessor.filter.process(image: imageProcessor.image) else { return }

                let locale = Bundle.main.preferredLocalizations.first ?? "en"
                let title = imageProcessor.filter.getDisplayNameByLocale(locale)
                cell.setup(image: image, title: title)
                
                if indexPath.row == lastSelectedIndex {
                    cell.setFocus()
                }
            }
            
            // If there are too many filers, using async method to
            // get a better user experience
            if indexPath.row > 3 {
                DispatchQueue.main.async {
                    setupCell()
                }
            } else {
                setupCell()
            }
        }
    }
}

