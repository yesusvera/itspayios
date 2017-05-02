//
//  SecuritySettingsView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/22/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class SecuritySettingsView: UITableViewController {
    @IBOutlet weak var textFieldCurrentPassword: UITextField!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var textFieldNewPasswordConfirmation: UITextField!
    
    @IBOutlet weak var buttonUpdatePasswordValue: UIButton!
    @IBOutlet weak var buttonComunicateValue: UIButton!
    
    @IBOutlet weak var labelNotificationsAlert: UILabel!
    @IBOutlet weak var labelCardBlock: UILabel!
    @IBOutlet weak var labelUseAbroad: UILabel!
    @IBOutlet weak var labelUseInternet: UILabel!
    @IBOutlet weak var labelSake: UILabel!
    
    @IBOutlet weak var switchNotificationsAlertValue: UISwitch!
    @IBOutlet weak var switchCardBlockValue: UISwitch!
    @IBOutlet weak var switchUseAbroadValue: UISwitch!
    @IBOutlet weak var switchUseInternetValue: UISwitch!
    @IBOutlet weak var switchSakeValue: UISwitch!
    
    @IBOutlet weak var segmentedControlLostStealingValue: UISegmentedControl!
    
    var cardViewController : UIViewController!
    
    var virtualCard : Credenciais!
    
    var securitySettings : SecuritySettings?
    
    var isUpdateCardPasswordOpen = false
    var isComunicateLostStealingOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Ajustes de Segurança"
        
        getSecuritySettings()
        updateViewInfo()
    }
    
    func getSecuritySettings() {
        let url = CardsController.createSecuritySettingsURLPath(virtualCard)
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
            
            if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                if let value = dataResponse.result.value {
                    self.securitySettings = SecuritySettings(object: value)
                    
                    self.updateViewInfo()
                }
            }
        })
    }
    
    func updateViewInfo() {
        if let securitySettings = securitySettings {
            if let value = securitySettings.habilitaUsoPessoa {
                switchUseInternetValue.isOn = value
                
                if switchUseInternetValue.isOn {
                    labelUseInternet.text = "Habilitado"
                    labelUseInternet.textColor = UIColor.colorFrom(hex: COLOR_GREEN_HEX)
                } else {
                    labelUseInternet.text = "Desabilitado"
                    labelUseInternet.textColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                }
            }
            if let value = securitySettings.habilitaExterior {
                switchUseAbroadValue.isOn = value
                
                if switchUseAbroadValue.isOn {
                    labelUseAbroad.text = "Habilitado"
                    labelUseAbroad.textColor = UIColor.colorFrom(hex: COLOR_GREEN_HEX)
                } else {
                    labelUseAbroad.text = "Desabilitado"
                    labelUseAbroad.textColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                }
            }
            if let value = securitySettings.habilitaSaque {
                switchSakeValue.isOn = value
                
                if switchSakeValue.isOn {
                    labelSake.text = "Habilitado"
                    labelSake.textColor = UIColor.colorFrom(hex: COLOR_GREEN_HEX)
                } else {
                    labelSake.text = "Desabilitado"
                    labelSake.textColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                }
            }
            if let value = securitySettings.habilitaEcommerce {
                switchCardBlockValue.isOn = !value
                
                if !switchCardBlockValue.isOn {
                    labelCardBlock.text = "Desbloqueado"
                    labelCardBlock.textColor = UIColor.colorFrom(hex: COLOR_GREEN_HEX)
                } else {
                    labelCardBlock.text = "Bloqueado"
                    labelCardBlock.textColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                }
            }
            if let value = securitySettings.habilitaNotificacaoTransacao {
                switchNotificationsAlertValue.isOn = value
                
                if switchNotificationsAlertValue.isOn {
                    labelNotificationsAlert.text = "Habilitado"
                    labelNotificationsAlert.textColor = UIColor.colorFrom(hex: COLOR_GREEN_HEX)
                } else {
                    labelNotificationsAlert.text = "Desabilitado"
                    labelNotificationsAlert.textColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                }
            }
        }
    }
    
    
//    Action Update Password
    @IBAction func buttonUpdatePasswordAction(_ sender: UIButton) {
        
        let url = CardsController.createChangePinURLPath()
        if (textFieldNewPassword.text?.isEqual(textFieldNewPasswordConfirmation.text))!{
        
            let parameters = CardsController.createGeneratePinChangeParameters( virtualCard , senha: textFieldCurrentPassword.text! , novaSenha: textFieldNewPassword.text!)
        
            LoadingProgress.startAnimatingInWindow()
            Connection.request(url, method: .post, parameters: parameters) { (dataResponse) in
                LoadingProgress.stopAnimating()
            
                if let reponse :Bool? = dataResponse.result.isFailure {
                    
                    let buttonOk = UIAlertAction(title: "OK", style: .default, handler: { (response) in

                        self.textFieldNewPassword.text = ""
                        self.textFieldNewPasswordConfirmation.text = ""
                        self.textFieldCurrentPassword.text = ""
                        
                        self.isUpdateCardPasswordOpen = !self.isUpdateCardPasswordOpen
                        
                        self.tableView.beginUpdates()
                        self.tableView.reloadData()
                        self.tableView.endUpdates()

                    })
                    
                    AlertComponent.showAlert(title: "Sucesso", message: "Senha alterada com sucesso.", actions: [buttonOk], viewController: self)
                
                }else{
                    AlertComponent.showSimpleAlert(title: "Erro", message: "Erro ao alterar a senha.", viewController: self)
                
                }
            }
        }else{
            AlertComponent.showSimpleAlert(title: "Erro", message: "Senhas nao condizem.", viewController: self)
        }
    }
    
    @IBAction func switchNotificationsAlertAction(_ sender: UISwitch) {
        if sender.isOn {
            labelNotificationsAlert.text = "Habilitado"
            labelNotificationsAlert.textColor = UIColor.colorFrom(hex: COLOR_GREEN_HEX)
        } else {
            labelNotificationsAlert.text = "Desabilitado"
            labelNotificationsAlert.textColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
        }
        
        changeState(tipoEstado: TIPO_ESTADO_NOTIFICATOINS_ALERT)
    }
    
    // Switch Block Card
    @IBAction func switchCardBlockAction(_ sender: UISwitch) {
        if !sender.isOn {
            self.labekBlockCard(verific: false)
            buttonComunicateAction(sender , menssageInfo: "desbloquear este cartão")
        } else {
            self.labekBlockCard(verific: true)
            buttonComunicateAction(sender , menssageInfo: "bloquear este cartão")
        }
    }
    
    func buttonComunicateAction(_ sender: UISwitch , menssageInfo: String) {
        let message = "Deseja realmente " + menssageInfo + " ?"
        
        let yesAction = UIAlertAction(title: "Sim", style: .default) { (action) in
            
            self.changeState(tipoEstado: TIPO_ESTADO_CARD_BLOCK)
        }
        
        let noAction = UIAlertAction(title: "Não", style: .default) { (action) in
            if !sender.isOn{
                sender.setOn(true, animated: true)
                self.labekBlockCard(verific: true)
            }else{
                sender.setOn(false, animated: true)
                self.labekBlockCard(verific: false)
            }
        }
        
        AlertComponent.showAlert(title: "Atenção", message: message, actions: [yesAction, noAction], viewController: self)
    }
    
    func labekBlockCard(verific: Bool){
        if !verific {
            self.labelCardBlock.text = "Desbloqueado"
            self.labelCardBlock.textColor = UIColor.colorFrom(hex: COLOR_GREEN_HEX)
        }else {
           self.labelCardBlock.text = "Bloqueado"
           self.labelCardBlock.textColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
        }
    }
    
    @IBAction func switchUseAbroadAction(_ sender: UISwitch) {
        if sender.isOn {
            labelUseAbroad.text = "Habilitado"
            labelUseAbroad.textColor = UIColor.colorFrom(hex: COLOR_GREEN_HEX)
        } else {
            labelUseAbroad.text = "Desabilitado"
            labelUseAbroad.textColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
        }
        
        changeState(tipoEstado: TIPO_ESTADO_USE_ABROAD)
    }
    
    @IBAction func switchUseInternetAction(_ sender: UISwitch) {
        if sender.isOn {
            labelUseInternet.text = "Habilitado"
            labelUseInternet.textColor = UIColor.colorFrom(hex: COLOR_GREEN_HEX)
        } else {
            labelUseInternet.text = "Desabilitado"
            labelUseInternet.textColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
        }
        
        changeState(tipoEstado: TIPO_ESTADO_USE_INTERNET)
    }
    
    @IBAction func switchSakeAction(_ sender: UISwitch) {
        if sender.isOn {
            labelSake.text = "Habilitado"
            labelSake.textColor = UIColor.colorFrom(hex: COLOR_GREEN_HEX)
        } else {
            labelSake.text = "Desabilitado"
            labelSake.textColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
        }
        
        changeState(tipoEstado: TIPO_ESTADO_SAKE)
    }
    
    @IBAction func segmentedControlLostStealingAction(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func buttonComunicateAction(_ sender: UIButton) {
        var message = "Deseja realmente informar "
        
        if segmentedControlLostStealingValue.selectedSegmentIndex == 0 {
            message += "a perda deste cartão?"
        } else {
            message += "o roubo deste cartão? "
        }
        
        message += "Este cartão será cancelado e um novo cartão será emitido."
        
        let yesAction = UIAlertAction(title: "Sim", style: .default) { (action) in
            if self.segmentedControlLostStealingValue.selectedSegmentIndex == 0 {
                self.comunicateLost()
            } else {
                self.comunicateSteal()
            }
        }
        
        let noAction = UIAlertAction(title: "Não", style: .default) { (action) in }
        
        AlertComponent.showAlert(title: "Atenção", message: message, actions: [yesAction, noAction], viewController: self)
    }
    
    func changeState(tipoEstado : Int) {
        let url = CardsController.createSecuritySettingsChangeStateURLPath()
        
        let parameters = CardsController.createSecuritySettingsChangeStateParameters(virtualCard, tipoEstado: tipoEstado)
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .post, parameters: parameters, dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
          
            if !validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                
            }
        })
    }
    
    func comunicateLost() {
        let url = CardsController.createComunicateLostURLPath(virtualCard)
        
        let parameters = CardsController.createComunicateLostParameters(virtualCard)
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .post, parameters: parameters, dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
            
            if !validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                let message = getDataResponseMessage(dataResponse)
                
                AlertComponent.showSimpleAlert(title: "Erro", message: message, viewController: self)
            }
        })
    }
    
    func comunicateSteal() {
        let url = CardsController.createComunicateStealURLPath(virtualCard)
        
        let parameters = CardsController.createComunicateStealParameters(virtualCard)
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .post, parameters: parameters, dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
            
            if !validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                let message = getDataResponseMessage(dataResponse)
                
                AlertComponent.showSimpleAlert(title: "Erro", message: message, viewController: self)
            }
        })
    }
    
    @IBAction func buttonChangePasswordAction(_ sender: UIButton) {
        isUpdateCardPasswordOpen = !isUpdateCardPasswordOpen
        
        self.tableView.beginUpdates()
        self.tableView.reloadData()
        self.tableView.endUpdates()
    }
    
    @IBAction func buttonComunicateLostStealingAction(_ sender: UIButton) {
        isComunicateLostStealingOpen = !isComunicateLostStealingOpen
        
        self.tableView.beginUpdates()
        self.tableView.reloadData()
        self.tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let idProduto = virtualCard.idProdutoPlataforma {
            if idProduto == 2 || idProduto == 3 {
                if indexPath.row > 1 && indexPath.row <= 4 {
                    return 0
                }
            } else if idProduto == 4 {
                if indexPath.row > 2 && indexPath.row <= 4 {
                    return 0
                }
            }
        }
        
        if !isUpdateCardPasswordOpen {
            if indexPath.row > 4 && indexPath.row <= 9 {
                return 0
            }
        }
        if !isComunicateLostStealingOpen {
            if indexPath.row > 10 {
                return 0
            }
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
