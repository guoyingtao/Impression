//
//  FilterCollectionView.swift
//  Impression
//
//  Created by Echo on 11/19/18.
//

import UIKit

class FilterCollectionView: UICollectionView {

    var image: UIImage?
    var myDataSource: CollectionDataSource<(filter: FilterProtocol, image: UIImage)>?
    
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
    
    var didSelectFilter: (FilterProtocol) -> Void = { _ in }
    var lastSelectedIndex = 0
    
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
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell else {
            return
        }
        
        if lastSelectedIndex != indexPath.row {
            lastSelectedIndex = indexPath.row
            cell.setFocus()
        } else {
            lastSelectedIndex = 0
            cell.removeFocus()
            
            NotificationCenter.default.post(name: .selectDefaultCell, object: nil)
        }
        
        guard let filter = myDataSource?.models[lastSelectedIndex].filter else {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.didSelectFilter(filter)
        }
    }
}
