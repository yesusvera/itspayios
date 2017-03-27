//
//  TokenCheck.swift
//  Itspay
//
//  Created by Junior Braga on 26/02/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class TokenCheckView:  UIViewController {
    
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var codeErrorLabel: UILabel!
    var codeAcess : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeErrorLabel.isHidden = true
        
        self.title = "Esqueci a Senha"
       
        let registerLoginObject = LoginController.createRequestTokenParameters()
        let url = Repository.createServiceURLFromPListValue(.services, key: "requestToken")
        
        Connection.request(url, method: .post, parameters: registerLoginObject, dataResponseJSON: { (dataResponse) in
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                
            }
        })
    }
    
    @IBAction func requestNewCode(_ sender: Any) {
        
        let registerLoginObject = LoginController.createRequestTokenParameters()
        let url = Repository.createServiceURLFromPListValue(.services, key: "requestToken")
        
        Connection.request(url, method: .post, parameters: registerLoginObject, dataResponseJSON: { (dataResponse) in
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
            }
        })
    }


    
    func isFormValid() -> Bool {
        
        codeErrorLabel.isHidden = false
        
        //guards
        guard let codeTokenForm = code.text else {
            return false
        }

        if codeTokenForm.isEmptyOrWhitespace() {
           return false
        }else{
            codeAcess = codeTokenForm
            codeErrorLabel.isHidden = true
            return true
        }
    }
    

    
    @IBAction func checkCode(_ sender: Any) {
        if isFormValid() {
            let registerLoginObject = LoginController.createValidTokenParameters(chaveExterna: codeAcess)
            let url = Repository.createServiceURLFromPListValue(.services, key: "validTokenService")
            
            Connection.request(url, method: .put, parameters: registerLoginObject, dataResponseJSON: { (dataResponse) in
                if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                    self.performSegue(withIdentifier: "validToken", sender: self)
                }
            })
        }
    }
}
