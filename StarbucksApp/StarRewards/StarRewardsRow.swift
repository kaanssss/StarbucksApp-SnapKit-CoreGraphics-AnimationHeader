//
//  StarRewardsRow.swift
//  StarbucksApp
//
//  Created by Kaan Yalçınkaya on 14.11.2022.
//

import UIKit

class StarRewardsRow: UIView {
    
    let starAndPoints = StarAndPoints()
    let descriptionLabel = UILabel()
    
    init(numberOfPoints: String, description: String) {
        starAndPoints.pointsLabel.text = numberOfPoints
        descriptionLabel.text = description
        
        super.init(frame: .zero)
        
        style()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StarRewardsRow {
    
    func style() {
        starAndPoints.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.sizeToFit()
    }
    
    func layout() {
        addSubview(starAndPoints)
        addSubview(descriptionLabel)
        
        starAndPoints.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        descriptionLabel.heightAnchor.constraint(equalToConstant: descriptionLabel.frame.size.height).setActiveBreakable()
        
        starAndPoints.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(starAndPoints.snp.trailing).inset(-4)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 10, height: 16)
    }
}
