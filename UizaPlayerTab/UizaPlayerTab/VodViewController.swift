//
//  VodViewController.swift
//  UizaPlayerTab
//
//  Created by le anh duc on 4/18/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit
import UizaSDK
//import FrameLayoutKit

class VodViewController: UIViewController {
    let playerViewController = UZPlayerViewController()
    let domainApiTxt = UITextField()
    let domainKeyTxt = UITextField()
    let entityIdTxt = UITextField()
//    let label1 = UILabel()
//    let label2 = UILabel()
    let label3 = UILabel()
    let loadEntityBtn = UIButton()
    var frameLayout : StackFrameLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        label1.text = "Domain api:"
//        label2.text = "Domain key:"
        label3.text = "Entity id:"
        loadEntityBtn.setTitle("Load video", for: .normal)
        loadEntityBtn.setTitleColor(.black, for: .normal)
        loadEntityBtn.addTarget(self, action: #selector(self.loadEntityBtnClicked), for: .touchUpInside)
        playerViewController.autoFullscreenWhenRotateDevice = false
        playerViewController.player.controlView.theme = UZTheme2()
        playerViewController.player.controlView.showControlView()
        playerViewController.setFullscreen(fullscreen: false)
//        playerViewController.player.loadVideo(entityId: "d09a35a7-6fce-461f-a008-67a6a959845a")
        view.addSubview(playerViewController.view)
        view.addSubview(label3)
        view.addSubview(entityIdTxt)
        view.addSubview(loadEntityBtn)
        frameLayout = StackFrameLayout(direction: .vertical)
        frameLayout.append(view: playerViewController.view).heightRatio = 9/16
        let entityId = DoubleFrameLayout(direction: .horizontal, alignment: .top, views: [label3, entityIdTxt])
        entityId.spacing = 10
        //set layout for entity id components
        frameLayout.append(frameLayout: entityId).configurationBlock = { layout in
            //top, left, bottom, right
            layout.edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        }
        frameLayout.append(view: loadEntityBtn)
        view.addSubview(frameLayout)
        
        
        
    }
    
    //auto hide keyboard if textfield lose focus
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            if entityIdTxt.isFirstResponder && touch.view != entityIdTxt{
                entityIdTxt.resignFirstResponder()
            }
        }
        super.touchesBegan(touches, with: event)
    }
    
    
    //load entity
    @objc func loadEntityBtnClicked(){
        let entityId = entityIdTxt.text
        if(!entityId!.isEmpty){
            playerViewController.player.loadVideo(entityId: entityId ?? "")
        }
    }
    

    
    public func stopPlay(){
        if(playerViewController.player.isPlaying){
            playerViewController.player.pause()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        frameLayout.frame = view.bounds
    }
    
    override public var shouldAutorotate: Bool{
        return true
    }
    
    

}
