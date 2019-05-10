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

class VodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let playerViewController = UZPlayerViewController()
//    let loadEntityBtn = UIButton()
    
    private var videoList: [String] = []
    private var videoIds: [String] = []
    let videoTableIdentifier = "videoTableIdentifier"
    private var videoTableView: UITableView!
    
    var frameLayout : StackFrameLayout! //https://github.com/kennic/NKFrameLayoutKit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerViewController.autoFullscreenWhenRotateDevice = false
        playerViewController.player.controlView.theme = UZTheme2()
        playerViewController.player.controlView.showControlView()
        playerViewController.setFullscreen(fullscreen: false)
        view.addSubview(playerViewController.view)
        loadVideoList()
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        videoTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight - 100))
        videoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        videoTableView.dataSource = self
        videoTableView.delegate = self
        view.addSubview(videoTableView)
        frameLayout = StackFrameLayout(direction: .vertical)
        frameLayout.append(view: playerViewController.view).heightRatio = 9/16
        
        frameLayout.append(view: videoTableView).heightRatio = 12/16
        view.addSubview(frameLayout)        
    }
    
    func loadVideoList() -> Void{
        UZContentServices().loadEntity(metadataId: nil, publishStatus: .success, page: 0, limit: 20, completionBlock: {(videos, error) in
            if(error != nil){
                print("Error: \(error)")
            }else{
                self.videoTableView.beginUpdates()
                for video in videos!{
                    self.videoList.append(video.name)
                    self.videoIds.append(video.id)
//                    print("Video: \(video.name)")
                    self.videoTableView.insertRows(at: [IndexPath(row: self.videoList.count - 1, section: 0)], with: .automatic)
                }
                
                self.videoTableView.endUpdates()
                
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: videoTableIdentifier)
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: videoTableIdentifier)
        }
        cell?.textLabel?.text = videoList[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Section: \(indexPath.section)")
//        print("Row: \(indexPath.row)")
        let index = indexPath.row
        playerViewController.player.loadVideo(entityId: self.videoIds[index])
    }
    
    //auto hide keyboard if textfield lose focus
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first{
//            if entityIdTxt.isFirstResponder && touch.view != entityIdTxt{
//                entityIdTxt.resignFirstResponder()
//            }
//        }
//        super.touchesBegan(touches, with: event)
//    }
    
    
    

    
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
