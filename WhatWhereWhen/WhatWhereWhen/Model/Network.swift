//
//  Network.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 11.07.2022.
//

import Foundation

class Network {
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func parse(jsonData: Data) -> [Question] {
        do {
            let decodedData = try JSONDecoder().decode([Question].self, from: jsonData)
            
            decodedData.forEach {
                print("№       : \($0.id)")
                print("Title   : \($0.title)")
                print("Question: \($0.question)")
                print("Answer  : \($0.answer)")
                print("===================================")
            }
            return decodedData
            
        } catch {
            print("Decode error")
        }
        return [Question]()
    }
    
    func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }
}
