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
    
    let viewController = UZLiveStreamViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewController.liveEventId = "live_event_id"
        self.present(viewController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    public func stopLiveStream(){
    }

}
