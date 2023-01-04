//
//  HistoryViewCell.swift
//  StarbucksApp
//
//  Created by Kaan Yalçınkaya on 29.11.2022.
//

import UIKit

class HistoryViewCell: UITableViewCell {
    
    let starView = makeSymbolImageView(systemName: "star")
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        config()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var transaction: Transaction? {
        didSet {
            guard let tx = transaction else { return }
            titleLabel.text = "\(tx.amount) Stars \(tx.type)"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
            dateLabel.text = dateFormatter.string(from: tx.date)
        }
    }
}

extension HistoryViewCell {
    
    func config() {
        backgroundColor = .tileBrown
        selectionStyle = .none
        
        starView.translatesAutoresizingMaskIntoConstraints = false
        starView.tintColor = .starYellow
        starView.contentMode = .scaleAspectFit
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubview(starView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        
        starView.snp.makeConstraints { make in
          make.leading.equalToSuperview().offset(16)
          make.height.width.equalTo(36)
          make.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
          make.leading.equalTo(starView.snp.trailing).offset(16)
          make.centerY.equalToSuperview()
        }

        dateLabel.snp.makeConstraints { make in
          make.trailing.equalToSuperview().offset(32)
          make.centerY.equalToSuperview()
        }

    }
    
}
