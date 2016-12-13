//
//  WebView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/13/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class WebView: UIViewController, NSURLConnectionDelegate, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    //MARK: -
    
    var isDone = false
    var urlConnection : NSURLConnection!
    var requestObj : URLRequest!
    var selectedURL : URL?
    var textTitle = ""
    
    var buttonClose = UIBarButtonItem()
    var buttonShare = UIBarButtonItem()
    
    //MARK: - View Life Cycle
    //MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = textTitle
        
        //Create Buttons
        buttonShare = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.buttonShareAction(sender:)))
        
        navigationItem.rightBarButtonItems = [buttonShare]
    }
    
    //MARK: - Initialization
    //MARK: -
    
    func initWebView() {
        if let url = selectedURL {
            requestObj = URLRequest(url: url)
            
//            var stringCookies = ""
//            for cookie in ServiceConnection.cookies {
//                stringCookies += "\(cookie.name)=\(cookie.value);"
//            }
            
//            requestObj.setValue(stringCookies, forHTTPHeaderField: "Cookie")
            
            print("URL WEBVIEW: \(url)")

            urlConnection = NSURLConnection(request: requestObj, delegate: self)!
        }
    }
    
    //MARK: - Web View
    //MARK: -
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Did finish load")
        
        activityIndicator.isHidden = true
        buttonShare.isEnabled = true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("Did start load")
    }
    
    func connection(_ connection: NSURLConnection, didFailWithError error: Error){
        print("DidFailWithError: \(error)")
    }
    
    private func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: URLProtectionSpace) -> Bool{
        return protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
    }
    
    func connection(_ connection: NSURLConnection, didReceive challenge: URLAuthenticationChallenge){
        print("Did receive authentication challenge = \(challenge.protectionSpace.authenticationMethod)")
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust  {
            print("Send credential Server Trust")
            
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            challenge.sender!.use(credential, for: challenge)
        }
    }
    
    
    func connection(_ connection: NSURLConnection, didCancel challenge: URLAuthenticationChallenge){
        print("DidCancelAuthenticationChallenge")
    }
    
    func connection(_ connection: NSURLConnection, didReceiveResponse response:
        
        URLResponse){
        print("Received response")
        
        webView.loadRequest(requestObj)
    }
    
    //MARK: - Actions
    //MARK: -
    
    func barButtonShareAction() {
        let fileSaved = downloadFile()
        //        let urlSavedFile = NSURL(
        if let data = NSData(contentsOfFile: fileSaved) {
            let objectsToShare = [data]
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityViewController.completionWithItemsHandler = {(string, result, items, error) -> Void in
                print("ActivityViewController Completed: \(string)\nResult: \(result)\nItems: \(items)\nError: \(error)")
            }
            
            if #available(iOS 9.0, *) {
                activityViewController.excludedActivityTypes = [
                    UIActivityType.postToFacebook,
                    UIActivityType.postToTwitter,
                    UIActivityType.postToWeibo,
                    UIActivityType.assignToContact,
                    UIActivityType.postToFlickr,
                    UIActivityType.postToVimeo,
                    UIActivityType.postToTencentWeibo,
                    UIActivityType.copyToPasteboard
                ]
            }
            
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonShareAction(sender: UIButton) {
        barButtonShareAction()
    }
    
    func buttonCloseAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Other
    //MARK: -
    
    func downloadFile() -> String {
        if let url = selectedURL {
            let data = NSData(contentsOf: url)
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let filePath = "\(documentsPath)/temp.pdf"
            
            do {
                try data?.write(toFile: filePath, options: .atomicWrite)
            } catch {
                print("error")
            }
            return filePath
        }
        return ""
    }
}
