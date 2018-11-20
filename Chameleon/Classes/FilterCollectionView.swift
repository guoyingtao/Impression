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
        print(indexPath)
    }
}
