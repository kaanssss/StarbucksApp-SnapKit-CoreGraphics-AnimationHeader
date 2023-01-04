//
//  HistoryService.swift
//  StarbucksApp
//
//  Created by Kaan Yalçınkaya on 29.11.2022.
//

import Foundation

enum ServiceError: Error {
    case server
    case parsing
}

struct HistoryService {
    static let shared = HistoryService()
    
    func fetchTransactions(completion: @escaping ((Result<[Transaction], Error>) -> Void)) {
        let url = URL(string: "https://uwyg0quc7d.execute-api.us-west-2.amazonaws.com/prod/history")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            print("data: \(data)")
            print("response \(response)")
            print("error \(error)")


            
            if let error = error {
                DispatchQueue.main.async {
                    completion(Result.failure(error))
                    print("1-error kontrol")
                }
            }
            
            guard let data = data else {return}
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(Result.failure(ServiceError.server))
                print("2-http kontrol")
                return

            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            print("3-decode kontrol")

            
            do {
                let result = try decoder.decode(History.self, from: data)
                DispatchQueue.main.async {
                    completion(Result.success(result.transactions))
                    print("4-dispatch kontrol")

                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(Result.failure(ServiceError.parsing))
                    print("5-error kontrol")

                }
            }
        }
        task.resume()
    }
}
