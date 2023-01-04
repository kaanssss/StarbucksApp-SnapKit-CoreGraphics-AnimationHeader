//
//  ViewController.swift
//  StarbucksApp
//
//  Created by Kaan Yalçınkaya on 7.09.2022.
//

import UIKit
import SnapKit

class HomeViewController: StarbucksViewController {
    
    let topSpacerView = UIView()
    let headerView = HomeHeaderView()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let scanButton = UIButton()
    
    var headerViewTopConstraint: NSLayoutConstraint?
    
//    struct ScanButtonSpacing {
//        static let height: CGFloat = 60
//        static let width: CGFloat = 170
//
//    }

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    //    lazy var titleStackView: UIStackView = {
    //        let stackView = UIStackView(arrangedSubviews: [headerView,
    //                                                       tableView])
    //        stackView.axis = .vertical
    //        stackView.alignment = .fill
    //        stackView.distribution = .fill
    //        stackView.spacing = 8
    //        return stackView
    //    }()
    
    
//    let cellId = "cellId"
    let tiles = [
        RewardsTileViewController(),
        TileViewController(title: "Breakfast made meatless", subtitle: "Try the Beyond Meat, Cheddar & Egg Breakfast Sandwich. Vegetarian and protein-packed.", imageName: "meatless"),
        TileViewController(title: "Uplifting our communities", subtitle: "Thanks to our partners' nominations, the Starbucks Foundation is donating $145K to more than 50 local charities.", imageName: "communities"),
        TileViewController(title: "Spend at least $15 for 50 Bonus Stars", subtitle: "Collect 50 Bonus Star when you spend at least $15 pre-tax.", imageName: "bonus")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        
        setTabBarImage(imageName: "house.fill", title: "Home")
        
        style()
        
        layout()
        
        setupScrollView()
    }
    
    
    func setUpNavBar() {
        navigationController?.navigationBar.topItem?.title = "Good Afternoon"
    }
    
    func setupScrollView() {
        scrollView.delegate = self
    }
    
}

extension HomeViewController {
    func style() {
        
        view.backgroundColor = .backgroundWhite
        topSpacerView.backgroundColor = .white
        containerView.backgroundColor = .backgroundWhite
        
        topSpacerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 8
        
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        scanButton.setTitle("Scan in store", for: .normal)
        scanButton.titleLabel?.minimumScaleFactor = 0.5
        scanButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        scanButton.titleLabel?.adjustsFontSizeToFitWidth = true
        scanButton.backgroundColor = .lightGreen
        scanButton.setTitleColor(.white, for: .normal)
        scanButton.layer.cornerRadius = 30
        
        headerView.delegate = self
        
    }
    
    func layout() {
        view.addSubview(topSpacerView)
        view.addSubview(containerView)
        containerView.addSubview(headerView)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addSubview(scanButton)
        
        for tile in tiles {
            addChild(tile)
            stackView.addArrangedSubview(tile.view)
            tile.didMove(toParent: self)
        }
        
        headerViewTopConstraint = headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        NSLayoutConstraint.activate([

            headerViewTopConstraint!,
            
        ])
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        topSpacerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.leading.trailing.equalTo(scrollView)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView)
        }
        
        //hata burda
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).priority(250)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
            
        }
        
        scanButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(60)
            make.width.equalTo(170)
        }
    }
    
}


