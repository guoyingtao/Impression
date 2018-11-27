//
//  FilterViewController.swift
//  Chameleon
//
//  Created by Echo on 11/16/18.
//

import UIKit

public protocol FilterViewControllerProtocal {
    func didSelectFilter(image: UIImage)
}

public enum FilterViewControllerMode {
    case normal
    case customizable
}

public class FilterViewController: UIViewController {
    
    let containerHeight: CGFloat = 160
    
    var image: UIImage?
    var demoView: FilterDemoImageView?
    var selectedFilter: FilterProtocal?
    var filterCollectionView: FilterCollectionView?
    var stackView: UIStackView?
    
    var containerVerticalHeightConstraint: NSLayoutConstraint?
    var containerHorizontalWidthConstraint: NSLayoutConstraint?
    
    var mode: FilterViewControllerMode = .normal
    
    var delegate: FilterViewControllerProtocal?
    
    init(image: UIImage, mode: FilterViewControllerMode = .normal) {
        self.image = image
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = image else {
            return
        }
        
        if mode == .normal {
            navigationController?.isNavigationBarHidden = true
            navigationController?.isToolbarHidden = false
            
            createToolbar()
        }
        
        let bigImageHeight = max(view.frame.width - containerHeight, view.frame.height - containerHeight)
        guard let bigImage = resizeImage(image: image, targetSize: CGSize(width: bigImageHeight, height: bigImageHeight)) else {
            return
        }
        
        guard let smallImage = resizeImage(image: image, targetSize: CGSize(width: containerHeight - 10, height: containerHeight - 10)) else {
            return
        }
        
        demoView = FilterDemoImageView(frame: .zero, image: bigImage)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.itemSize = filterThumbnailSize
        
        filterCollectionView = FilterCollectionView(frame: view.bounds, collectionViewLayout: layout)
        filterCollectionView?.image = smallImage

        filterCollectionView?.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "FilterCell")
        
        let collectionViewModel = FilterCollectionViewModel()
        filterCollectionView?.viewModel = collectionViewModel
        
        filterCollectionView?.didSelectFilter = {[weak self] filter in
            guard let self = self else { return }
            self.selectedFilter = filter
            self.demoView?.image = filter.process(image: bigImage)
        }
        
        stackView = UIStackView()
        view.addSubview(stackView!)
        
        initLayout()
        setCollectionViewDirection()
        updateLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filterCollectionView?.reloadData()
    }
    
    func setCollectionViewDirection() {
        guard let flowLayout = filterCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }

        if UIDevice.current.orientation.isLandscape {
            flowLayout.scrollDirection = .vertical
        } else {
            flowLayout.scrollDirection = .horizontal
        }
        
        flowLayout.invalidateLayout()
    }
    
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setCollectionViewDirection()
    }
    
    @objc func rotated() {
        updateLayout()
        view.layoutIfNeeded()
    }
    
    fileprivate func initLayout() {
        guard let collectionView = filterCollectionView else {
            return
        }
        
        stackView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView?.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        stackView?.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        containerVerticalHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: containerHeight)
        containerHorizontalWidthConstraint = collectionView.widthAnchor.constraint(equalToConstant: containerHeight)
    }
    
    fileprivate func updateLayout() {
        guard let demoView = demoView, let collectionView = filterCollectionView else {
            return
        }
        
        stackView?.removeArrangedSubview(demoView)
        stackView?.removeArrangedSubview(collectionView)
        
        if UIApplication.shared.statusBarOrientation.isPortrait {
            stackView?.axis = .vertical
            
            stackView?.addArrangedSubview(demoView)
            stackView?.addArrangedSubview(collectionView)
            
            containerHorizontalWidthConstraint?.isActive = false
            containerVerticalHeightConstraint?.isActive = true
        } else {
            stackView?.axis = .horizontal
            
            if UIApplication.shared.statusBarOrientation == .landscapeLeft {
                stackView?.addArrangedSubview(collectionView)
                stackView?.addArrangedSubview(demoView)
            } else {
                stackView?.addArrangedSubview(demoView)
                stackView?.addArrangedSubview(collectionView)
            }
            
            containerVerticalHeightConstraint?.isActive = false
            containerHorizontalWidthConstraint?.isActive = true
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

// Create Toolbar UI for normal mode
extension FilterViewController {
    func createToolbar() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissSelf))
        let confirmButton = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(confirm))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbarItems = [cancelButton, spacer, confirmButton]
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true)
    }
    
    @objc func confirm() {
        let spinner = displaySpinner(onView: self.view)
        
        func processImage() {
            guard let image = applySelectedFilter() else {
                return
            }
            
            removeSpinner(spinner: spinner)            
            delegate?.didSelectFilter(image: image)
        }
        
        DispatchQueue.global().async {
            processImage()
        }
    }
}

// Public API
extension FilterViewController {
    func applySelectedFilter() -> UIImage? {
        guard let image = image else { return nil }
        return selectedFilter?.process(image: image)
    }
}
