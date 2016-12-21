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
typealias handlerDownloadResponseData = (Alamofire.DownloadResponse<Data>) -> Swift.Void

class Connection {
    static let sharedConnection = Connection()
    
    var headers : HTTPHeaders?
    
    var cookies = [HTTPCookie]()
    
    var stringCookies = ""
    
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
            Connection.getCookies(response: response)
            
            print("URL: \(url)\nJSON Response: \(response)\n")
            
            dataResponseJSON(response)
        }
    }
    
    static func imageFrom(_ path : String, downloadResponseData: @escaping handlerDownloadResponseData) {
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        
        var url = Repository.createServiceURLFromPListValue(.services, key: "images")
        
        url += "/\(path)"
        
        Alamofire.download(url, to: destination).responseData { response in
            print("URL IMAGE: \(url)\nJSON Response: \(response)\n")
            
            downloadResponseData(response)
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
                
                if LoginController.sharedInstance.loginResponseObject != nil {
                    if let token = LoginController.sharedInstance.loginResponseObject.token {
                        Connection.setHeadersAuthorization(with: token)
                    }
                }
            }
        }
    }
    
    static func setHeadersAuthorization(with token : String) {
        let headers = [
            "AuthorizationPortador": token,
            "Content-Type": "application/json",
            "Accept": "application/json;charset=UTF-8",
            "Cookie": Connection.sharedConnection.stringCookies
        ]
        
        Connection.sharedConnection.headers = headers
    }
    
    static func removeSession() {
        Connection.sharedConnection.headers = nil
//        Connection.sharedConnection.cookies = [HTTPCookie]()
//        Connection.sharedConnection.stringCookies = ""
        LoginController.sharedInstance.loginResponseObject = nil
    }
}
