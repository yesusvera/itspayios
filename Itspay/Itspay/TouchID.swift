//
//  TouchID.swift
//
//  Created by Arthur Augusto on 9/29/15.
//  Copyright © 2015 bb. All rights reserved.
//

import Foundation
import LocalAuthentication

class TouchID {
    static func authenticateUserTouchID(_ handlerAuthenticationResult: @escaping (Bool, String, Bool) -> ()) {
        // Get the local authentication context.
        let context = LAContext()
        
        // Declare a NSError variable.
        var error: NSError?
        
        // Set the reason string that will appear on the authentication alert.
        let reasonString = "A autenticação pela biometria é necessária para efetuar o login"
        
        // Check if the device can evaluate the policy.
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, error) in
                if success {
                    OperationQueue.main.addOperation({ () -> Void in
                        handlerAuthenticationResult(true, "SUCCESS TOUCH ID", false)
                    })
                } else {
                    if let error = error as? NSError {
                        print(error.localizedDescription)
                        
                        switch error.code {
                            case LAError.Code.systemCancel.rawValue:
                                print("Authentication was cancelled by the system")
                            case LAError.Code.userCancel.rawValue:
                                print("Authentication was cancelled by the user")
                            case LAError.Code.userFallback.rawValue:
                                print("User selected to enter custom password")
                                OperationQueue.main.addOperation({ () -> Void in
                                    handlerAuthenticationResult(false, "Usuário selecionado para entrar com senha personalizada", true)
                                })
                            default:
                                print("Authentication failed")
                                OperationQueue.main.addOperation({ () -> Void in
                                    handlerAuthenticationResult(false, "Erro no reconhecimento da biometria.", false)
                                })
                        }
                    }
                }
            })
        } else {
            var errorMessage = "Erro no reconhecimento da biometria."
            
            // If the security policy cannot be evaluated then show a short message depending on the error.
            switch error!.code{
                case LAError.Code.touchIDNotEnrolled.rawValue:
                    print("TouchID is not enrolled")
                    errorMessage = "TouchID não está registrado"
                case LAError.Code.passcodeNotSet.rawValue:
                    print("A passcode has not been set")
                    errorMessage = "A senha não foi definida"
                default:
                    // The LAError.TouchIDNotAvailable case.
                    print("TouchID not available")
                    errorMessage = "TouchID não está disponível"
            }
            
            // Optionally the error description can be displayed on the console.
            print(error?.localizedDescription)
            
            // Show the custom alert view to allow users to enter the password.
            handlerAuthenticationResult(false, errorMessage, true)
        }
        
    }
    
    static func isTouchIDAvaiable() -> (isAvaiable : Bool, message : String) {
        let context = LAContext()
        
        var error: NSError?

        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) == false {
            var errorMessage = "Falha na Autenticação"
            
            switch error!.code{
                case LAError.Code.touchIDNotEnrolled.rawValue:
                    errorMessage = "TouchID não está registrado"
                case LAError.Code.passcodeNotSet.rawValue:
                    errorMessage = "A senha não foi definida"
                default:
                    errorMessage = "TouchID não está disponível"
            }
            
            print(error?.localizedDescription)
            
            return (false, errorMessage)
        }
        return (true, "")
    }
}
