//
//  BalanceView.swift
//  StarbucksApp
//
//  Created by Kaan Yalçınkaya on 28.09.2022.
//

import UIKit

class BalanceView: UIView {
    
    let pointsLabel = UILabel()
    let starView = makeSymbolImageView(systemName: "star.fill")
    let starBalanceLabel = UILabel()
    
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
        pointsLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle).bold()
        pointsLabel.text = "12"
        
        starView.translatesAutoresizingMaskIntoConstraints = false
        starView.tintColor = .starYellow
        starView.contentMode = .scaleAspectFit
        
        starBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        starBalanceLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        starBalanceLabel.textColor = .label
        starBalanceLabel.text = "Star balance"
        
        
    }
    
    func layout() {
        
        addSubview(pointsLabel)
        addSubview(starView)
        addSubview(starBalanceLabel)
        
        pointsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        starView.snp.makeConstraints { make in
            make.leading.equalTo(pointsLabel.snp.trailing).offset(-2)
            make.centerY.equalTo(pointsLabel.snp.centerY).offset(4)
            make.height.equalTo(15)
        }
        
        starBalanceLabel.snp.makeConstraints { make in
            make.top.equalTo(pointsLabel.snp.bottom)
            make.leading.equalTo(pointsLabel.snp.leading)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
