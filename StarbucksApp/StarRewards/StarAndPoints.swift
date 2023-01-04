//
//  StarAndPoints.swift
//  StarbucksApp
//
//  Created by Kaan Yalçınkaya on 14.11.2022.
//

import UIKit

class StarAndPoints: UIView {
    
    let pointsLabel = UILabel()
    let starView = makeSymbolImageView(systemName: "star.fill", scale: .small)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.font = UIFont.preferredFont(forTextStyle: .callout).bold()
        pointsLabel.textAlignment = .right
        
        starView.translatesAutoresizingMaskIntoConstraints = false
        starView.tintColor = .starYellow
        starView.contentMode = .scaleAspectFit
    }
    
    func layout() {
        
        addSubview(pointsLabel)
        addSubview(starView)
        
        pointsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalTo(starView.snp.leading).inset(-2)
            make.bottom.equalToSuperview()
        }
        
        starView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 60, height: 16)
    }
}
