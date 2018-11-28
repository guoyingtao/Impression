//
//  ViewController.swift
//  Chameleon
//
//  Created by starecho on 11/16/2018.
//  Copyright (c) 2018 starecho. All rights reserved.
//

import UIKit
import Chameleon

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "sunflower.jpg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showFilters(_ sender: Any) {
        let image = UIImage(named: "sunflower.jpg")!
        let vc = Chameleon.createFilterViewController(image: image, delegate: self, useDefaultFilters: true)
        
        Chameleon.addCustomFilters(filters: [ToasterFilter(), ClarendonFilter(), HazeRemovalFilter()])
        
        present(vc, animated: true, completion: nil)
    }    
}

extension ViewController: FilterViewControllerProtocal {
    func didSelectFilter(image: UIImage) {
        imageView.image = image
    }
}

