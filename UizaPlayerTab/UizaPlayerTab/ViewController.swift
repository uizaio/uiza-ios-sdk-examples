//
//  ViewController.swift
//  UizaPlayerTab
//
//  Created by le anh duc on 4/18/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit
import UizaSDK

//some global variables

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var appIdTxt: UITextField!
    @IBOutlet weak var appKeyTxt: UITextField!
    @IBOutlet weak var appUriTxt: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private let apiVersions = ["v3", "v4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.            
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return apiVersions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return apiVersions[row]
    }


    
    @IBAction func appSettingClick(_ sender: UIButton) {
        let appId = appIdTxt?.text ?? ""
        let appKey = appKeyTxt?.text ?? ""
        let appUri = appUriTxt?.text ?? ""
        let index = pickerView.selectedRow(inComponent: 0)
        let version = apiVersions[index]
        if(!appId.isEmpty && !appKey.isEmpty && !appUri.isEmpty){
            //next to screen
            if version == "v4"{
                UizaSDK.initWith(appId: appId, token: appKey, api: appUri, enviroment: .production, version: .v4)//can use .v3
            }else{
                UizaSDK.initWith(appId: appId, token: appKey, api: appUri, enviroment: .production, version: .v3)//can use .v3
            }
            
            self.performSegue(withIdentifier: "ShowMainTabBar", sender: nil)
        }else{
            let alertController = UIAlertController(title: "Warning!", message: "You have not set app's info", preferredStyle: .actionSheet)
            let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: { action in
            })
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }

}

