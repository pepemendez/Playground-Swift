//
//  Connector+GoogleApi.swift
//  Test
//
//  Created by José Méndez on 7/28/20.
//  Copyright © 2020 José Méndez. All rights reserved.
//

import Foundation

extension Connector{
    /**
     Test to make queries to google search public api
     
     - Parameter completion: Closure to call
     - Parameter query: Query string, can be a word
     - Parameter success: *true* if status code is in range 200-299
     - Parameter httpCode: Http status code response
     - Parameter response: Raw response decoded as String
     
     - returns: a response as string, if success is *false* response will be a message if *true* response will be the json response as string
     */
    func GoogleQuery(query: String, completion: @escaping (_ success: Bool, _ httpCode: Int, _ response: String) -> ()){
        
        let url = String(format:"\(Endpoints.GoogleQuery)%@", query)

        
        unsignedGet(requestUrl: url, completion: completion);
    }
    
    /* Post example
     
     func GoogleQuery(param1: String, param2: String, completion: @escaping (_ success: Bool, _ httpCode: Int, _ response: String) -> ()){
         
         let json: [String: Any] = ["param1": param1,
                                    "param2": param2];
         
         do{
             let jsonData =  try JSONSerialization.data(withJSONObject: json)
             unsignedPost(requestUrl: <<URL>>, params: jsonData, completion: completion);
         }catch{
             completion(false, 0, "APP_ERROR");
         }
     }
     */
}
