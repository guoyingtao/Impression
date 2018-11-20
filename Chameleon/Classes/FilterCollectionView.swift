//
//  FilterCollectionView.swift
//  Chameleon
//
//  Created by Echo on 11/19/18.
//

import UIKit

class FilterCollectionView: UICollectionView {

    var image: UIImage?
    var myDataSource: CollectionDataSource<(filter: FilterProtocal, image: UIImage)>?
    
    var viewModel: FilterCollectionViewModel? {
        didSet {
            guard let filters = viewModel?.filters, let image = image else {
                return
            }
            
            let imageProcessors = filters.map { ($0, image) }
            
            myDataSource = .make(for: imageProcessors)
            self.dataSource = myDataSource
        }
    }
    
    var didSelectFilter: (FilterProtocal) -> Void = { _ in }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension FilterCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let filter = myDataSource?.models[indexPath.row].filter else {
            return
        }
        
        didSelectFilter(filter)
    }
}

extension CollectionDataSource where Model == (filter: FilterProtocal, image: UIImage) {
    static func make(for imageProcessors: [(FilterProtocal, UIImage)],
                     reuseIdentifier: String = "FilterCell") -> CollectionDataSource {
        return CollectionDataSource (
            models: imageProcessors,
            reuseIdentifier: reuseIdentifier
        ) { (imageProcessor, cell, indexPath) in
            cell.backgroundColor = UIColor.white
            
            guard let cell = cell as? FilterCollectionViewCell else {
                return
            }
            
            func setupCell() {
                guard let image = imageProcessor.filter.process(image: imageProcessor.image) else { return }
                cell.setup(image: image, title: imageProcessor.filter.name)
            }
            
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

