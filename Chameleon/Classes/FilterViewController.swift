//
//  FilterViewController.swift
//  Chameleon
//
//  Created by Echo on 11/16/18.
//

import UIKit

public class FilterViewController: UIViewController {
    
    var image: UIImage?
    var imageView: UIImageView?
    var filterCollectionContainer: UIView?
    var stackView: UIStackView?
    
    var containerVerticalHeightConstraint: NSLayoutConstraint?
    var containerHorizontalWidthConstraint: NSLayoutConstraint?
    
    init(image: UIImage) {
        self.image = image
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
        
        imageView = UIImageView()
        imageView?.contentMode = .scaleAspectFit
        imageView?.image = image
        filterCollectionContainer = UIView()
        filterCollectionContainer?.backgroundColor = .red
        stackView = UIStackView()
        
        view.addSubview(stackView!)
        stackView?.addArrangedSubview(imageView!)
        stackView?.addArrangedSubview(filterCollectionContainer!)
        
        stackView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionContainer?.translatesAutoresizingMaskIntoConstraints = false
        
        stackView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView?.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        stackView?.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        containerVerticalHeightConstraint = filterCollectionContainer?.heightAnchor.constraint(equalToConstant: 80)
        containerHorizontalWidthConstraint = filterCollectionContainer?.widthAnchor.constraint(equalToConstant: 80)
        
        updateLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
    }
    
    @objc func rotated() {
        updateLayout()
    }
    
    public override func viewDidLayoutSubviews() {
        print(stackView!.frame)
    }
    
    fileprivate func updateLayout() {
        guard let imageView = imageView, let container = filterCollectionContainer else {
            return
        }
        
        stackView?.removeArrangedSubview(imageView)
        stackView?.removeArrangedSubview(container)
        
        if UIApplication.shared.statusBarOrientation.isPortrait {
            containerVerticalHeightConstraint?.isActive = true
            containerHorizontalWidthConstraint?.isActive = false

            stackView?.axis = .vertical
            
            stackView?.addArrangedSubview(imageView)
            stackView?.addArrangedSubview(container)
        } else {
            containerVerticalHeightConstraint?.isActive = false
            containerHorizontalWidthConstraint?.isActive = true

            stackView?.axis = .horizontal
            
            if UIApplication.shared.statusBarOrientation == .landscapeLeft {
                stackView?.addArrangedSubview(container)
                stackView?.addArrangedSubview(imageView)
            } else {
                stackView?.addArrangedSubview(imageView)
                stackView?.addArrangedSubview(container)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
