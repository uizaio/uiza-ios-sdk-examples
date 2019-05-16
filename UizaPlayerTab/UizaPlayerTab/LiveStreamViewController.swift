//
//  LiveStreamViewController.swift
//  UizaPlayerTab
//
//  Created by le anh duc on 4/18/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit
import UizaSDK

class LiveStreamViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var liveName: UITextField!
    let modeList:[String] = ["push", "pull"]
    let encodeList:[String] = ["Yes", "No"]
    let dvrList:[String] = ["DVR", "No DVR"]
    
    private let modePickerComponent = 0
    private let encodePickerComponent = 1
    private let dvrPickerComponent = 2
    
    @IBOutlet weak var modePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == modePickerComponent {
            return modeList.count
        }else if component == encodePickerComponent {
            return encodeList.count
        }else{
            return dvrList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == modePickerComponent{
            return modeList[row]
        }else if component == encodePickerComponent{
            return encodeList[row]
        }else{
            return dvrList[row]
        }
    }
    
    @IBAction func createLive(_ sender: UIButton) {
        let mode = modePicker.selectedRow(inComponent: modePickerComponent)
        let encode = modePicker.selectedRow(inComponent: encodePickerComponent)
        let dvr = modePicker.selectedRow(inComponent: dvrPickerComponent)
        if(liveName.text == nil){
            return
        }
        if(liveName.text!.isEmpty){
            return
        }
        let params:[String:Any] = ["name": liveName.text!, "mode" : modeList[mode], "encode": encode, "dvr": dvr, "linkStream": [], "resourceMode": "single"]
        //create live event
        LiveStreamViewController.sendRequest(parameters: params, link: "https://" + sdkUri + "/api/public/v4/live/entity", protocol: "POST"){response, error in
            if error != nil {
                print("\(error)")
            }else{
//                print("\(response!["data"])")
                //start live event
                let data:[String:Any] = response!["data"] as! [String : Any]
                let liveId = data["id"]
                let liveParams:[String:Any] = ["id": liveId!]
                LiveStreamViewController.sendRequest(parameters: liveParams, link: "https://" + sdkUri + "/api/public/v4/live/entity/feed", protocol: "POST"){ response,error in
                    if error != nil {
                        print("\(error)")
                    }else{
                        let type:String = response!["type"] as! String
                        if type == "SUCCESS"{
                            sdkLiveId = liveId as! String
                            self.startLiveStream()
                        }else{

                        }
                    }
                }
                
            }
        }
    }
    
    func startLiveStream(){
        DispatchQueue.main.async {
            let liveViewController = LiveViewController()
            self.present(liveViewController, animated: true, completion: nil)
        }
    }
    
    static func sendRequest(parameters params:[String: Any], link urlLink:String, protocol proto: String, completion: @escaping ([String: Any]?, Error?) -> Void){
        let requestBody = try? JSONSerialization.data(withJSONObject: params)
        let url = URL(string: urlLink)
        var request = URLRequest(url: url!)
        request.httpMethod = proto
        request.httpBody = requestBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(String(describing: requestBody))", forHTTPHeaderField: "Content-Length")
        request.setValue(sdkKey, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
                completion(nil, error)
                return
            }
            let response = try? JSONSerialization.jsonObject(with: data, options: [])
            if let response = response as? [String: Any]{
                print("\(response)")
                completion(response, nil)
                return
            }
        }
        task.resume()
    }

}
