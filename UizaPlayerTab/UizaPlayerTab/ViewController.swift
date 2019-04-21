//
//  ViewController.swift
//  UizaPlayerTab
//
//  Created by le anh duc on 4/18/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        let vodTab = viewController as? VodViewController
        let liveStreamTab = viewController as? LiveStreamViewController
        if tabBarIndex == 0{
            liveStreamTab?.stopLiveStream()
        }else{
            vodTab?.stopPlay()
            
        }
    }

}

