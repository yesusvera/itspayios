//
//  PickerFieldsDataHelper.swift
//  PickerDataHelper
//
//  Created by Allan Alves on 28/10/16.
//  Copyright © 2016 Allan Alves. All rights reserved.
//

import UIKit

@objc protocol PickerFieldsDataHelperDelegate: class {
    @objc optional func pickerFieldsDataHelper(_ dataHelper: PickerDataHelper, didSelectObject selectedObject: AnyObject?, withTitle title: String?)
}

@objc class PickerDataHelper: NSObject {
    var pickerView: UIPickerView?
    var datePicker: UIDatePicker?
    var textField: UITextField?
    var isDateType: Bool
    var titles = [String]()
    var objects = [AnyObject]()
    var selectedObject: AnyObject?
    var defaultOption: (String,AnyObject)?
    
    init(textField: UITextField, isDateType: Bool) {
        let pickerView = UIPickerView()
        self.pickerView = pickerView
        self.textField = textField
        self.isDateType = isDateType
    }
}

class PickerFieldsDataHelper: NSObject, PickerFieldsDataHelperDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: PickerFieldsDataHelperDelegate?
    var dataHelpers = [PickerDataHelper]()
    
    var doneButtonTitle = "OK"
    
    //Show first item with nil object
    var useDefaultFirstItem = true
    var initWithDefaultFirstItemSelected = true //if useDefaultFirstItem is true
    var defaultFirstItemTitle = "Todos" //Use if useDefaultFirstItem is true
    
    //Date Type
    var dateFormat = "dd/MM/yyyy"
    var initWithTodayDate = false
    
    //Nav Item
    var showPlaceholderAsTitle = false
    
    //MARK: - Initialization -
    
    func addDataHelpers(_ textFields: [UITextField], isDateType: Bool) {
        for textField in textFields {
            addDataHelper(textField, isDateType: isDateType)
        }
    }
    
    func addDataHelper(_ textField: UITextField, isDateType: Bool) {
        let dataHelper = PickerDataHelper(textField: textField, isDateType: isDateType)
        dataHelper.isDateType = isDateType
        
        if isDateType {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            dataHelper.datePicker = datePicker
            textField.inputView = datePicker
            
            if initWithTodayDate {
                datePicker.date = Date()
                refreshDate(dataHelper)
            }
        } else {
            //Picker View
            let pickerView = UIPickerView()
            dataHelper.pickerView = pickerView
            
            //Set Delegate, DataSource & Correspondent TextFields
            pickerView.delegate = self
            pickerView.dataSource = self
            //TextField InputView
            textField.inputView = pickerView
            
            //Add first default item if needed
            if useDefaultFirstItem {
                dataHelper.titles.append(defaultFirstItemTitle)
                if initWithDefaultFirstItemSelected {
                    textField.text = defaultFirstItemTitle
                }
            }
        }
        //Input Accessory View
        addToolBarPickerViews(doneButtonTitle, textField: textField)
        
        dataHelpers.append(dataHelper)
        refreshAllPickers()
    }
    
    func dataHelper(_ textField: UITextField) -> PickerDataHelper? {
        for item in dataHelpers {
            if textField == item.textField {
                return item
            }
        }
        return nil
    }
    
    //MARK: - Content -
    
    func addTitleAndObjectInDataHelper(_ textField: UITextField, title: String, object: AnyObject) {
        if let dataHelper = dataHelper(textField) {
            dataHelper.titles.append(title)
            dataHelper.objects.append(object)
            refreshAllPickers()
        }
    }
    
    func addTitleAndObjectInDataHelper(_ textField: UITextField, title: String, object: AnyObject, isDefault: Bool) {
        addTitleAndObjectInDataHelper(textField, title: title, object: object)
        if isDefault {
            if let dataHelper = dataHelper(textField) {
                dataHelper.defaultOption = (title,object)
                selectDefaultOption(dataHelper)
            }
        }
    }
    
    //Return selected object for given textfield
    func selectedObjectForTextField(_ textField: UITextField) -> AnyObject? {
        if let dataHelper = dataHelper(textField) {
            if let object = dataHelper.selectedObject {
                return object
            }
        }
        return nil
    }
    
    //Select option on textField and selectedObject property
    func selectDefaultOption(_ dataHelper: PickerDataHelper) {
        if let defaultOption = dataHelper.defaultOption {
            let title = defaultOption.0
            let object = defaultOption.1
            //Select default title
            if let pickerView = dataHelper.pickerView {
                if let index = dataHelper.titles.index(of: title) {
                    pickerView.selectRow(index, inComponent: 0, animated: false)
                } else {
                    pickerView.selectRow(0, inComponent: 0, animated: false)
                }
            }
            if let textField = dataHelper.textField {
                textField.text = title
            }
            dataHelper.selectedObject = object
        }
    }
    
    //MARK: - Picker Views -
    
    func refreshAllPickers() {
        for dataHelper in dataHelpers {
            if let pickerView = dataHelper.pickerView {
                pickerView.reloadAllComponents()
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        for dataHelper in dataHelpers {
            if dataHelper.pickerView == pickerView {
                return dataHelper.titles[row]
            }
        }
        return "❔"
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        for dataHelper in dataHelpers {
            if dataHelper.pickerView == pickerView {
                return dataHelper.titles.count
            }
        }
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //MARK: - Other -
    
    func selectDate(_ date: Date, textField: UITextField) {
        if let dataHelper = dataHelper(textField) {
            if dataHelper.isDateType {
                if let datePicker = dataHelper.datePicker {
                    datePicker.date = date
                    refreshDate(dataHelper)
                }
            }
        }
    }
    
    func clearAllFields() {
        for dataHelper in dataHelpers {
            if let textField = dataHelper.textField {
                if dataHelper.isDateType {
                    //Date Type
                    if initWithTodayDate { //Init With Today
                        if let datePicker = dataHelper.datePicker {
                            datePicker.date = Date()
                            refreshDate(dataHelper)
                        }
                    } else {
                        textField.text = ""
                    }
                    //Normal Type
                } else {
                    //Select first
                    if let pickerView = dataHelper.pickerView {
                        pickerView.selectRow(0, inComponent: 0, animated: false)
                    }
                    textField.text = ""
                    dataHelper.selectedObject = nil
                    //Select default option if it exists
                    if dataHelper.defaultOption != nil {
                        selectDefaultOption(dataHelper)
                    } else { //If there is no default option, set first if needed
                        if useDefaultFirstItem { //Init With First Default Title
                            if initWithDefaultFirstItemSelected {
                                textField.text = defaultFirstItemTitle
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Input Accessory View -
    
    //Add input accessory view with done button
    func addToolBarPickerViews(_ title : String, textField : UITextField) {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black.withAlphaComponent(0.1)
        toolBar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(self.closePicker))
        closeButton.tintColor = UIColor.blue
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, closeButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
    }
    
    //Set selected date as selected object, and textfield title
    func refreshDate(_ dataHelper: PickerDataHelper) {
        if let datePicker = dataHelper.datePicker {
            dataHelper.selectedObject = datePicker.date as AnyObject?
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            if let textField = dataHelper.textField {
                textField.text = dateFormatter.string(from: datePicker.date)
            }
        }
    }
    
    //MARK: - Actions -
    
    //Hide keyboard, set selected object and set title of textfield
    func closePicker() {
        //TDOO: Get selected picker item and set text of textfield
        for dataHelper in dataHelpers {
            if let textField = dataHelper.textField {
                if textField.isFirstResponder {
                    textField.superview?.endEditing(true) //Hide Keyboard
                    if dataHelper.isDateType {
                        refreshDate(dataHelper)
                    } else {
                        if let pickerView = dataHelper.pickerView {
                            let row = pickerView.selectedRow(inComponent: 0) //Get Index
                            if row < dataHelper.titles.count && row > -1 {
                                let title = dataHelper.titles[row] //Get Title
                                textField.text = title
                                
                                if useDefaultFirstItem {
                                    //Use nil as default - if index given is not in objects/titles range
                                    dataHelper.selectedObject = nil
                                    if row > 0 && row < dataHelper.titles.count {
                                        dataHelper.selectedObject = dataHelper.objects[row-1]
                                    }
                                } else {
                                    if row > -1 && row < dataHelper.titles.count {
                                        dataHelper.selectedObject = dataHelper.objects[row]
                                    }
                                }
                                //When user taps the done button to select an option
                                self.delegate?.pickerFieldsDataHelper?(dataHelper,
                                                                       didSelectObject: dataHelper.selectedObject,
                                                                       withTitle: title)
                            }
                        }
                    }
                }
            }
        }
    }
    
}










