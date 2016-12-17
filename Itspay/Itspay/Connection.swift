//
//  Connection.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/13/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import Alamofire

typealias handlerResponseJSON = (Alamofire.DataResponse<Any>) -> Swift.Void

class Connection {
    static let sharedConnection = Connection()
    
    var headers : HTTPHeaders?
    
    static func request(_ url : String, responseJSON: @escaping handlerResponseJSON) {
        let data = Alamofire.request(url)
        
        data.responseJSON { (response) in
            print("URL: \(url)\nJSON Response: \(response)")
            
            responseJSON(response)
        }
    }
    
    static func request(_ url : String, method : HTTPMethod, parameters : [String : Any]?, dataResponseJSON: @escaping handlerResponseJSON) {
        let data = Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: Connection.sharedConnection.headers)
        
        data.responseJSON { (response) in            
            print("URL: \(url)\nJSON Response: \(response)\n")
            
            dataResponseJSON(response)
        }
    }
    
    static func setHeadersAuthorization(with token : String) {
        let headers = [
            "Authorization": token,
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json"
        ]
        
        Connection.sharedConnection.headers = headers
    }
}
