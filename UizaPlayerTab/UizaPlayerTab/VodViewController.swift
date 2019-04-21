//
//  VodViewController.swift
//  UizaPlayerTab
//
//  Created by le anh duc on 4/18/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit
import UizaSDK

class VodViewController: UIViewController {
    let playerViewController = UZPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UizaSDK.initWith(appId: "app_id", token: "app_token", api: "api_domain")
        UZContentServices().loadDetail(entityId: "entity_id", completionBlock: {(videoItem, error) in
            if error != nil {
                print("Error: \(error)")
            }else{
                print("Video: \(videoItem)")
            }
        })
        playerViewController.autoFullscreenWhenRotateDevice = false
        playerViewController.player.controlView.theme = UZTheme1()
        playerViewController.player.loadVideo(entityId: "entity_id")
        //        present(playerViewController, animated: true, completion: nil)
        self.view.addSubview(playerViewController.view)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    public func stopPlay(){
        if(playerViewController.player.isPlaying){
            playerViewController.player.pause()
        }
    }

}
