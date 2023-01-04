//
//  HomeHeaderView.swift
//  StarbucksApp
//
//  Created by Kaan Yalçınkaya on 7.09.2022.
//

import UIKit
import SnapKit

protocol HomeHeaderViewDelegate: AnyObject {
    func didTapHistoryButton(_ sender: HomeHeaderView)
}

class HomeHeaderView: UIView {
    
    let greeting = UILabel()
    let inboxButton = UIButton()
    let historyButton = UIButton()
    
    //    lazy var containerView: UIView = {
    //        let view = UIView()
    //        view.backgroundColor = .yellow
    //        return view
    //    }()
    
    weak var delegate: HomeHeaderViewDelegate?
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [greeting,
                                                       inboxButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        style()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHeaderView {
    func style() {
        
        backgroundColor = .white
        greeting.translatesAutoresizingMaskIntoConstraints = false
        greeting.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        greeting.text = "Good Afternoon, Kaan"
        greeting.numberOfLines = 0
        greeting.lineBreakMode = .byWordWrapping
        
        
        makeInboxButton()
        
        makeHistoryButton()
        
        historyButton.addTarget(self, action: #selector(historyButtonTapped(sender:)), for: .primaryActionTriggered)
        
    }
    
    func layout() {
        //        addSubview(containerView)
        addSubview(greeting)
        addSubview(inboxButton)
        addSubview(historyButton)
        
        greeting.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(inboxButton.snp.top)
        }
        
        historyButton.snp.makeConstraints { make in
            make.leading.equalTo(inboxButton.snp.trailing).offset(2)
            make.centerY.equalTo(inboxButton)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        inboxButton.snp.makeConstraints { make in
            make.top.equalTo(greeting.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().multipliedBy(1)
            make.width.height.equalToSuperview().multipliedBy(0.25)
        }
    }
}

extension HomeHeaderView {
    
    func makeInboxButton() {
        makeButton(button: inboxButton, systemName: "envelope", text: "Inbox")
    }
    
    func makeHistoryButton() {
        makeButton(button: historyButton, systemName: "calendar", text: "History")
    }
    
    func makeButton(button: UIButton, systemName: String, text: String) {
        button.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: systemName, withConfiguration: configuration)
        
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .secondaryLabel
        button.imageView?.contentMode = .scaleAspectFit
        
        button.setTitle(text, for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
    }
}

// MARK: Actions
extension HomeHeaderView {
    @objc func historyButtonTapped(sender: UIButton) {
        delegate?.didTapHistoryButton(self)
    }
}

