//
//  Connector.swift
//  MyPlayground
//
//  Created by José Méndez on 7/28/20.
//  Copyright © 2020 José Méndez. All rights reserved.
//

import UIKit

class Connector {
    
    public func sendRawURLRequest(request: URLRequest, completion: @escaping (Bool, Int, String) -> ()){
        dataTask(request: request, completion: completion)
    }
    
    public func unsignedPost(requestUrl: String, params: Data, completion: @escaping (Bool, Int, String) -> ()){
        unsignedRequest(requestUrl: requestUrl, method: "POST", params: params, completion: completion);
    }
    
    public func unsignedGet(requestUrl: String, completion: @escaping (Bool, Int, String) -> ()){
        unsignedRequest(requestUrl: requestUrl, method: "GET", completion: completion);
    }
    
    public func post(requestUrl: String, params: Data, completion: @escaping (Bool, Int, String) -> ()){
        signedRequest(requestUrl: requestUrl, method: "POST", params: params, completion: completion);
    }
    
    public func get(requestUrl: String, completion: @escaping (Bool, Int, String) -> ()){
        signedRequest(requestUrl: requestUrl, method: "GET", completion: completion);
    }
    
    private func signedRequest(requestUrl: String, method: String, params: Data? = nil, completion: @escaping (Bool, Int, String) -> ()){
        var request = URLRequest(url: URL(string: requestUrl)!);
        request.httpMethod = method;
        request.httpBody = params;
        request.authorizationHeader = UserPreferences.jwtToken;
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        dataTask(request: request, completion: completion);
    }
    
    private func unsignedRequest(requestUrl: String, method: String, params: Data? = nil, completion: @escaping (Bool, Int, String) -> ()){
        var request = URLRequest(url: URL(string: requestUrl)!);
        request.httpMethod = method;
        request.httpBody = params;
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        dataTask(request: request, completion: completion);
    }
    
    
    private func dataTask(request: URLRequest, completion: @escaping (Bool, Int, String) -> ()){
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        print("request: \(request) method: \(String(request.httpMethod!))")
        print("headers: \(request.customHeaders)")
        print("body:    \(request.customBody)")
        
        session.dataTask(with: request) { (data, response, error) -> Void in
            if let data = data {
                
                let error = try? JSONDecoder().decode(Error.self, from: data);
                
                if let msg = error?.Message {
                    completion(false, (response as? HTTPURLResponse)!.statusCode, msg);
                }
                else if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode && error == nil{
                    if response.statusCode == 204 {
                        completion(false, response.statusCode, "Invalid");
                    }
                    else{
                        completion(true, response.statusCode, String(decoding: data, as: UTF8.self));
                    }
                }
                else {
                    completion(false, (response as? HTTPURLResponse)!.statusCode, String(decoding: data, as: UTF8.self));
                }
            }
            else{
                completion(false, 0, "APP_ERROR");
            }
            }.resume()
    }
}
