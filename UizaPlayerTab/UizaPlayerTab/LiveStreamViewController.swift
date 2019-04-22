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

    let liveStreamViewController = UZLiveStreamViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        liveStreamViewController.liveEventId = "8614f49c-c1db-48c8-8289-e88ef99fc8ba"
        self.present(liveStreamViewController, animated: true, completion: nil)
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
        if(liveStreamViewController.isLive){
            liveStreamViewController.askToStop()
        }
    }

}
