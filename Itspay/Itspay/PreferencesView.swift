//
//  PreferencesView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/20/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class PreferencesView: UITableViewController {
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldCurrentPassword: UITextField!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var textFieldNewPasswordConfirmation: UITextField!

    @IBOutlet weak var buttonValue: UIButton!
    
    var isEmailEditing = false
    var isPasswordEditing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Ajustes Gerais"
        
        updateViewInfo()
    }
    
    func updateViewInfo() {
        
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                isEmailEditing = !isEmailEditing
                
                if isEmailEditing {
                    isPasswordEditing = false
                }
                
                buttonValue.setTitle("Trocar Email", for: .normal)
            }
            if indexPath.row == 2 {
                isPasswordEditing = !isPasswordEditing
                
                if isPasswordEditing {
                    isEmailEditing = false
                }
                
                buttonValue.setTitle("Trocar Senha", for: .normal)
            }
        }
        
        tableView.beginUpdates()
        tableView.reloadData()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 1 && !isEmailEditing {
                return 0
            }
            if !isPasswordEditing {
                if indexPath.row > 2 && indexPath.row <= 5 {
                    return 0
                }
            }
            if !isPasswordEditing && !isEmailEditing {
                if indexPath.row == 6 {
                    return 0
                }
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
