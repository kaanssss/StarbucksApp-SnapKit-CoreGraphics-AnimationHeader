//
//  RewardTileView.swift
//  StarbucksApp
//
//  Created by Kaan Yalçınkaya on 28.09.2022.
//

import UIKit

class RewardsTileView: UIView {
    
    let balanceView = BalanceView()
    let rewardsButton = UIButton()
    let rewardsGraphView = RewardsGraphView()
    let starRewardsView = StarRewardsView()
    var detailsButton = UIButton()
    
    //Animasyon için yükseklik ayarı.
    var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        
        style()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RewardsTileView {
    
    func style() {
        
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        rewardsGraphView.translatesAutoresizingMaskIntoConstraints = false
        starRewardsView.translatesAutoresizingMaskIntoConstraints = false
        
        makeRewardsOptionsButton()
        detailsButton = makeClearButton(withText: "Details")
        
        
    }
    
    func makeRewardsOptionsButton() {
        rewardsButton.translatesAutoresizingMaskIntoConstraints = false
        
        rewardsButton.addTarget(self, action: #selector(rewardsOptionsTapped), for: .primaryActionTriggered)
        
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "chevron.down", withConfiguration: configuration)
        
        rewardsButton.setImage(image, for: .normal)
        rewardsButton.imageView?.tintColor = .label
        rewardsButton.imageView?.contentMode = .scaleAspectFit
        
        rewardsButton.setTitle("Rewards options", for: .normal)
        rewardsButton.setTitleColor(.label, for: .normal)
        rewardsButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        rewardsButton.semanticContentAttribute = .forceRightToLeft
        
        
    }
    
    func layout() {
        
        addSubview(balanceView)
        addSubview(rewardsButton)
        addSubview(rewardsGraphView)
        addSubview(starRewardsView)
        addSubview(detailsButton)
        
        //Animasyon için yükseklik kısıtlaması, görünüme açık şekilde ayarlamak vs.
        heightConstraint = starRewardsView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            
            heightConstraint!
            
        ])
        
        balanceView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        rewardsButton.snp.makeConstraints { make in
            make.centerY.equalTo(balanceView.pointsLabel)
            make.trailing.equalToSuperview().inset(24)
        }
        
        rewardsGraphView.snp.makeConstraints { make in
            make.top.equalTo(balanceView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.trailing.leading.equalToSuperview().inset(16)
            
        }
        
        starRewardsView.snp.makeConstraints { make in
            make.top.equalTo(rewardsGraphView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
            starRewardsView.isHidden = true
            
        }
        
        detailsButton.snp.makeConstraints { make in
            make.top.equalTo(starRewardsView.snp.bottom).offset(16)
            make.leading.equalTo(balanceView)
            make.trailing.equalTo(balanceView)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
    }
    
    
    //Gerçek cihaz genişliğimizi ve yüksekliğimizi öğrendikten sonra grafiğimizi şekillendirmek için.
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rewardsGraphView.actualFrameWidth = frame.width
        rewardsGraphView.drawRewardsGraph()
    }
}

extension RewardsTileView {
    @objc func rewardsOptionsTapped() {
        
        if heightConstraint?.constant == 0 {
            self.setChevronUp()
            
            let heightAnimator = UIViewPropertyAnimator(duration: 0.75, curve: .easeOut) {
                self.heightConstraint?.constant = 270
                self.layoutIfNeeded()
            }
            
            heightAnimator.startAnimation()
            
            //Bu animasyonun sebebi, asıl animasyon devreye girdiğinde aradaki parlaklığı engellemek.
            let alphaAnimator = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
                self.starRewardsView.isHidden = false
                self.starRewardsView.alpha = 1
            }
            alphaAnimator.startAnimation(afterDelay: 0.5)
            
        }
        else {
            self.setChevronDown()
            
            let animator = UIViewPropertyAnimator(duration: 0.75, curve: .easeInOut) {
                self.heightConstraint?.constant = 0
                self.starRewardsView.isHidden = true
                self.starRewardsView.alpha = 0
                self.layoutIfNeeded()
            }
            animator.startAnimation()
        }
    }
    
    @objc func detailsButtonTapped() {
        print("Details tapped!!!!")
    }
    
    private func setChevronUp() {
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "chevron.up", withConfiguration: configuration)
        rewardsButton.setImage(image, for: .normal)
    }
    
    private func setChevronDown() {
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "chevron.down", withConfiguration: configuration)
        rewardsButton.setImage(image, for: .normal)
    }
}
