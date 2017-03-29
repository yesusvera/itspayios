//
//  ForgotPassowordView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/4/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit
import PickerFieldsDataHelper


class ForgotPassowordView: UITableViewController ,PickerFieldsDataHelperDelegate{
    
    @IBOutlet weak var textFieldCPF: TextFieldCPFMask!
    @IBOutlet weak var textFieldBirthday: UITextField!
    
    
    @IBOutlet weak var labelErrorBirthday: UILabel!
    @IBOutlet weak var labelErrorCPF: UILabel!
    
    var cpf = ""
    var birthday : String!
    
    let pickerFieldsDataHelper = PickerFieldsDataHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Esqueci a Senha"
        
        
        pickerFieldsDataHelper.delegate = self
        
        pickerFieldsDataHelper.addDataHelpers([textFieldBirthday], isDateType: true)
        
        pickerFieldsDataHelper.doneButtonTitle = "OK"
        pickerFieldsDataHelper.initWithTodayDate = true

    }
    
    @IBAction func buttonRequestAction(_ sender: UIButton) {
        if isFormValid() {
            let url = Repository.createServiceURLFromPListValue(.services, key: "recoverPassword")
            
            let parameters = LoginController.createRecoverPasswordParameters(cpf,birthday: GetDateFromString(DateStr: textFieldBirthday.text!))
            
            Connection.request(url, method: .post, parameters: parameters, dataResponseJSON: { (dataResponse) in
                if !validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                    let message = getDataResponseMessage(dataResponse)
                    
                    if(message == "Login de acesso não identificado. "){
                        AlertComponent.showSimpleAlert(title: "Erro", message: message, viewController: self)
                    }else{
                        AlertComponent.showSimpleAlert(title: "Sucesso", message: message, viewController: self)
                    }
                }
            })
        }
    }
    
    
    func GetDateFromString(DateStr: String)-> String {
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let DateArray = DateStr.components(separatedBy: "/")
        let components = NSDateComponents()
        components.year = Int(DateArray[2])!
        components.month = Int(DateArray[1])!
        components.day = Int(DateArray[0])!
        
        let date = calendar?.date(from: components as DateComponents)
        
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "yyyy-MM-dd"
        
        let stringOfDate = dateFormate.string(from: date!)
        print(stringOfDate)
        
        return stringOfDate
    }
    
    func isFormValid() -> Bool {
        labelErrorCPF.isHidden = false
        labelErrorBirthday.isHidden = false
        
        var cpfError = false
        var birthdayError = false
        
        guard let cpfForm = textFieldCPF.text else {
            labelErrorCPF.text = "CPF vazio."
            return false
        }
        
        guard let birthdayForm = textFieldBirthday.text else {
            labelErrorBirthday.text = "Data de nascimento vazia."
            return false
        }
        
        if cpfForm.isEmptyOrWhitespace() {
            labelErrorCPF.text = "CPF vazio."
            
        }
        
        let cpfValidation = cpfForm.isCPFValid()
        
        if !cpfValidation.value {
            labelErrorCPF.text = cpfValidation.message
            
        }else {
            cpfError = true
            labelErrorCPF.isHidden = true
        }
        
        //Aniversário
        if birthdayForm.isEmptyOrWhitespace() {
            labelErrorBirthday.text = "Data de nascimento vazia."
        } else{
            birthdayError = true
            birthday = birthdayForm
            labelErrorBirthday.isHidden = true
        }
        
        
        if !cpfError || !birthdayError {
            return false
        }
        
        
        cpf = cpfForm
        labelErrorCPF.isHidden = true
        
        return true
    }
}
