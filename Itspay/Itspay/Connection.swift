//
//  Connection.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/13/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import Alamofire

class Connection {
    static func request(_ url : String, responseJSON: @escaping (Alamofire.DataResponse<Any>) -> Swift.Void) {
        let data = Alamofire.request(url)
        
        data.responseJSON { (response) in
            print("URL: \(url)\nJSON Response: \(response)")
            
            responseJSON(response)
        }
    }
    
    static func request(_ url : String, method : HTTPMethod, parameters : [String : Any]?, headers : HTTPHeaders?, dataResponseJSON: @escaping (Alamofire.DataResponse<Any>) -> Swift.Void) {
        let data = Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
        
        data.responseJSON { (response) in
            print("URL: \(url)\n\nJSON Response: \(response)\n\n")
            
            dataResponseJSON(response)
        }
    }
}
