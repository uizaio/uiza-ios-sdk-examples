//
//  ViewController.swift
//  UizaPlayerV4
//
//  Created by le anh duc on 4/12/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit
import UizaSDK
import FrameLayoutKit

class ViewController: UIViewController {

    let playerViewController = UZPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UizaSDK.initWith(appId: "01e137ad1b534004ad822035bf89b29f", token: "uap-01e137ad1b534004ad822035bf89b29f-b9b31f29", api: "teamplayer-api.uiza.co")
        UZContentServices().loadDetail(entityId: " aaa8d4f0-1099-4064-a912-cd57e963fb70", completionBlock: {(videoItem, error) in
            if error != nil {
                print("Error: \(error)")
            }else{
                print("Video: \(videoItem)")
            }
        })
        playerViewController.autoFullscreenWhenRotateDevice = true
        playerViewController.player.controlView.theme = UZTheme1()
        playerViewController.player.loadVideo(entityId: "aaa8d4f0-1099-4064-a912-cd57e963fb70")
//        present(playerViewController, animated: true, completion: nil)
        self.view.addSubview(playerViewController.view)
    }


}

