//
//  HistoryModel.swift
//  StarbucksApp
//
//  Created by Kaan Yalçınkaya on 9.12.2022.
//

import Foundation

struct History: Codable {
    let transactions: [Transaction]
}

struct Transaction: Codable {
    let id: Int
    let type: String
    let amount: String
    let date: Date

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case amount
        case date = "processed_at"
    }
}
