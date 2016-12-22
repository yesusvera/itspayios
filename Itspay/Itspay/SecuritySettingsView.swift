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
    
    var isUpdateCardPasswordOpen = false
    var isComunicateLostStealingOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Ajustes de Segurança"
    }
    
    @IBAction func buttonUpdatePasswordAction(_ sender: UIButton) {
        
    }
    
    @IBAction func switchNotificationsAlertAction(_ sender: UISwitch) {
    
    }
    
    @IBAction func switchCardBlockAction(_ sender: UISwitch) {
    
    }
    
    @IBAction func switchUseAbroadAction(_ sender: UISwitch) {
    
    }
    
    @IBAction func switchUseInternetAction(_ sender: UISwitch) {
    
    }
    
    @IBAction func switchSakeAction(_ sender: UISwitch) {
    
    }
    
    @IBAction func segmentedControlLostStealingAction(_ sender: UISegmentedControl) {
    
    }
    
    @IBAction func buttonComunicateAction(_ sender: UIButton) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            isUpdateCardPasswordOpen = !isUpdateCardPasswordOpen
            
            self.tableView.beginUpdates()
            self.tableView.reloadData()
            self.tableView.endUpdates()
        } else if indexPath.row == 10 {
            isComunicateLostStealingOpen = !isComunicateLostStealingOpen
            
            self.tableView.beginUpdates()
            self.tableView.reloadData()
            self.tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !isUpdateCardPasswordOpen {
            if indexPath.row > 0 && indexPath.row < 5 {
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
