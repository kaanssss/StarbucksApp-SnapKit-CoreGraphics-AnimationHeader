//
//  TileViewController.swift
//  StarbucksApp
//
//  Created by Kaan Yalçınkaya on 27.09.2022.
//

import UIKit

class TileViewController: UIViewController {
    
    let tileView = TileView()
    
    init(title: String, subtitle: String, imageName: String) {
        super.init(nibName: nil, bundle: nil)
        
        tileView.titleLabel.text = title
        tileView.subtitleLabel.text = subtitle
        tileView.imageView.image = UIImage(named: imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        
        layout()
    }
    
    func style() {
        
        tileView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func layout() {
        
        view.addSubview(tileView)
        
        tileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
