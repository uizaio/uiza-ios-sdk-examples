//
//  LiveStreamViewController.swift
//  UizaPlayerTab
//
//  Created by le anh duc on 4/18/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit
import UizaSDK

class LiveStreamViewController: UIViewController {
    
    @IBOutlet weak var liveName: UITextField!
    @IBOutlet weak var dvrSwitch: UISwitch!
    @IBOutlet weak var encodeSwitch: UISwitch!
    
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
    
    @IBAction func createLive(_ sender: UIButton) {
        let mode = "push"
        let encode = encodeSwitch.isOn ? 1 : 0
        let dvr = dvrSwitch.isOn ? 1 : 0
        if(liveName.text == nil){
            return
        }
        if(liveName.text!.isEmpty){
            return
        }
        let params:[String:Any] = ["name": liveName.text!, "mode" : mode, "encode": encode, "dvr": dvr, "linkStream": [], "resourceMode": "single"]
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
                            DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "Warning!", message: response!["message"] as! String, preferredStyle: .actionSheet)
                                let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: { action in
                                })
                                alertController.addAction(okAction)
                                self.present(alertController, animated: true, completion: nil)
                            }
                            
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
