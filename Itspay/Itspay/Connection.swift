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
    
    var cookies = [HTTPCookie]()
    
    var stringCookies = ""
    
    static func request(_ url : String, responseJSON: @escaping handlerResponseJSON) {
        let data = Alamofire.request(url)
        
        data.responseJSON { (response) in
            Connection.getCookies(response: response)
            
            print("URL: \(url)\nJSON Response: \(response)")
            
            responseJSON(response)
        }
    }
    
    static func request(_ url : String, method : HTTPMethod, parameters : [String : Any]?, dataResponseJSON: @escaping handlerResponseJSON) {
        let data = Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
        
        data.responseJSON { (response) in
            Connection.getCookies(response: response)
            
            print("URL: \(url)\nJSON Response: \(response)\n")
            
            dataResponseJSON(response)
        }
    }
    
    static func getCookies(response : DataResponse<Any>) {
        if Connection.sharedConnection.cookies.count == 0 {
            if let headerFields = response.response?.allHeaderFields as? [String: String], let url = response.request?.url {
                Connection.sharedConnection.cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)
                
                Connection.sharedConnection.stringCookies = ""
                for cookie in Connection.sharedConnection.cookies {
                    Connection.sharedConnection.stringCookies += "\(cookie.name)=\(cookie.value);"
                }
            }
        }
    }
    
    static func setHeadersAuthorization(with token : String) {
        let headers = [
            "Authorization": token,
            "Content-Type": "application/json",
            "Cookie": Connection.sharedConnection.stringCookies
        ]
        
        Connection.sharedConnection.headers = headers
    }
    
    static func removeSession() {
        Connection.sharedConnection.headers = nil
        Connection.sharedConnection.cookies = [HTTPCookie]()
        Connection.sharedConnection.stringCookies = ""
    }
}
