//
//  FloatViewController.swift
//  UizaPlayerTab
//
//  Created by le anh duc on 5/8/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit
import UizaSDK

class FloatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var videoList:[String] = []
    var uzVideoItems:[UZVideoItem] = []
    @IBOutlet weak var videoTable: UITableView!
    let videoTableIdentifier = "videoTableIdentifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVideo()
    }
    
    func loadVideo(){
        UZContentServices().loadEntity(metadataId: nil, publishStatus: .success, page: 0, limit: 20, completionBlock: {(videos, error) in
            if(error != nil){
                print("Error: \(error)")
            }else{
//                self.videoTable.beginUpdates()
                for video in videos!{
                    self.videoList.append(video.name)
                    self.uzVideoItems.append(video)
                    self.videoTable.insertRows(at: [IndexPath(row: self.videoList.count - 1, section: 0)], with: .automatic)
                }
                
//                self.videoTable.endUpdates()
                
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
        DispatchQueue.main.async {
            //only create new view if it's not initiated
            let viewController = FloatingPlayerViewController.currentInstance ?? FloatingPlayerViewController()
                viewController.present(with: self.uzVideoItems[indexPath.row]).player.controlView.theme = UZTheme1()
                viewController.floatingHandler?.allowsCornerDocking = true
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ViewController: UZPlayerDelegate{
    func UZPlayer(player: UZPlayer, playerStateDidChange state: UZPlayerState) {
        // called when player state was changed (buffering, buffered, readyToPlay,...)
    }
    func UZPlayer(player: UZPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        //called when loaded duration was changed
    }
    func UZPlayer(player: UZPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        //called when player time was changed
    }
    func UZPlayer(player: UZPlayer, playerIsPlaying playing: Bool) {
        //called when playing state was changed
    }
    
}

extension ViewController:UZFloatingPlayerViewProtocol{
    func floatingPlayer(_ player: UZFloatingPlayerViewController, didBecomeFloating: Bool) {
        //called when floating player became floating mode or backed to normal mode
    }
    
    func floatingPlayer(_ player: UZFloatingPlayerViewController, onFloatingProgress: CGFloat) {
        // called when user drag the player from normal mode to floating mode
    }
    
    func floatingPlayerDidDismiss(_ player: UZFloatingPlayerViewController) {
        //called when player was dismissed
    }
    
    
}
