//
//  MainTabViewController.swift
//  UizaPlayerTab
//
//  Created by le anh duc on 5/6/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        let vodTab = viewController as? VodViewController
        let liveStreamTab = viewController as? LiveStreamViewController
//        let settingTab = viewController as? SettingViewController
        if tabBarIndex == 0{//vod tab
        }
        else{//live stream tab
            vodTab?.stopPlay()

        }
    }

}
