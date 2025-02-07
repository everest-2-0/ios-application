//
//  NetworkManager.swift
//  ScanShape
//
//  Created by Vadim on 06.02.2025.
//

import Alamofire
import Foundation

final class NetworkManager{
    static let shared = NetworkManager()
    
    private init() {}
    
    func loginToAccount(number: String, password: String, completion: @escaping (Result<String, AFError>) -> Void){
        let url = "http://195.161.69.122:8080/api/users/login"
        let parameters: [String: Any] = [
            "number": number,
            "password": password
        ]

        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: ["accept": "*/*", "Content-Type": "application/json"])
            .responseString { response in
                switch response.result {
                case .success(let token):
                    completion(.success(token))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func register(name: String, number: String, password: String, gender: String, completion: @escaping (Result<String, AFError>) -> Void){
        let url = "http://195.161.69.122:8080/api/users/register"
        let parameters: [String: Any] = [
            "name": name,
            "number": number,
            "password": password,
            "gender": gender
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default)
        .responseString { response in
            switch response.result{
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
