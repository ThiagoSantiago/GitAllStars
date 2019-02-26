//
//  GitAllStarsApiRequest.swift
//  GitAllStars
//
//  Created by Thiago Santiago on 2/25/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

enum Result<T:Decodable> {
    case success(T)
    case failure(GitAllStarsError)
}

protocol GitAllStarsApiRequestProtocol {
    func request<T: Decodable>(_ request: GitAllStarsApiSetupProtocol, decodingType: T.Type,completion: @escaping (Result<T>) -> Void)
}


class GitAllStarsApiRequest: GitAllStarsApiRequestProtocol {
    
    func request<T>(_ request: GitAllStarsApiSetupProtocol, decodingType: T.Type, completion: @escaping (Result<T>) -> Void) {
        
        guard let urlRequest = self.buildURLRequest(request) else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
            }
            
            guard let data = data else {
                completion(.failure(.brokenData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknown("Could not cast to HTTPURLResponse object.")))
                return
            }
            
            completion(self.handler(statusCode: httpResponse.statusCode, dataResponse: data, decodingType: decodingType))
            
        }.resume()
    }
    
    private func buildURLRequest(_ request: GitAllStarsApiSetupProtocol) -> URLRequest? {
        
        guard let url = URL(string: "\(Constants.baseUrl)\(request.endpoint)") else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if request.method == .post {
            
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: request.parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        for (key, value) in request.headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
    
    private func handler<T: Decodable>(statusCode: Int, dataResponse: Data, decodingType: T.Type) -> Result<T> {
        
        switch statusCode {
        case 200...299:
            return parseJson(dataResponse, decodingType: decodingType)
        case 403:
            return Result.failure(.authenticationRequired)
            
        case 404:
            return Result.failure(.couldNotFindHost)
            
        case 500:
            return Result.failure(.badRequest)
            
        default: return Result.failure(.unknown(""))
        }
    }
    
    private func parseJson<T: Decodable>(_ response: Data, decodingType: T.Type) -> Result<T> {

        guard let obj = try? JSONDecoder().decode(decodingType, from: response) else {
            return Result.failure(GitAllStarsError.couldNotParseObject)
        }
        
        return Result.success(obj)
    }
}
