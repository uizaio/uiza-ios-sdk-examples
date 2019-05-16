//
//  LiveViewController.swift
//  UizaPlayerTab
//
//  Created by le anh duc on 5/8/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit
import UizaSDK
import LFLiveKit_

class LiveViewController: UZLiveStreamViewController {

    override open func videoConfiguration() -> LFLiveVideoConfiguration {
        let configuration = LFLiveVideoConfiguration()
        configuration.sessionPreset = .captureSessionPreset720x1280
        configuration.videoFrameRate = 24
        configuration.videoMaxFrameRate = 24
        configuration.videoMinFrameRate = 12
        configuration.videoBitRate = 1000 * 1000
        configuration.videoMaxBitRate = 1000 * 1000
        configuration.videoMinBitRate = 1000 * 1000
        configuration.videoSize = CGSize(width: 720, height: 1280)
        configuration.videoMaxKeyframeInterval = 12
        configuration.outputImageOrientation = .portrait
        configuration.autorotate = true
        return configuration
    }
    
    override open func audioConfiguration() -> LFLiveAudioConfiguration {
        let configuration = LFLiveAudioConfiguration.defaultConfiguration(for: .medium)!
        configuration.numberOfChannels = 2
        configuration.audioBitrate = ._128Kbps
        configuration.audioSampleRate = ._44100Hz
        return configuration
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.isRoundedButton = false
        startButton.cornerRadius = 5.0
        startButton.setBackgroundColor(UIColor(displayP3Red: 0.91, green: 0.31, blue: 0.28, alpha: 0.8), for: .normal)
        startButton.setBackgroundColor(UIColor(displayP3Red: 0.91, green: 0.31, blue: 0.28, alpha: 1.00), for: .highlighted)
        startButton.setBackgroundColor(UIColor(displayP3Red: 0.91, green: 0.31, blue: 0.28, alpha: 0.60), for: .disabled)
        startButton.title = "Go Live!"
        self.liveEventId = sdkLiveId
        self.livestreamUIView = UZLiveStreamUIView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let viewSize = view.bounds.size
        let labelSize = liveDurationLabel.sizeThatFits(viewSize)
        liveDurationLabel.frame = CGRect(x: 10, y: 10, width: labelSize.width, height: labelSize.height)
        startButton.frame = CGRect(x: 10, y: viewSize.height - 100, width: viewSize.width - 20, height: 45)
    }
    
    //when you stop live
    override func askToStop() {
        let alertControler = UIAlertController(title: "Confirm", message: "Do you really want to stop livestream?", preferredStyle: .alert)
        
        alertControler.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action) in
            alertControler.dismiss(animated: true, completion: nil)
        }))
        
        alertControler.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            alertControler.dismiss(animated: true, completion: nil)
            self.stopLive()
            self.dismiss(animated: true, completion: nil)
            //and we need to stop live event on server
            let params:[String:Any] = ["id": sdkLiveId]
            LiveStreamViewController.sendRequest(parameters: params, link: "https://" + sdkUri + "/api/public/v4/live/entity/feed?id=" + sdkLiveId, protocol: "PUT"){(response, error) in
                if error != nil {
                    print("\(error)")
                }else{
                    print("\(response)")
                }
            }
        }))
        
        self.present(alertControler, animated: true, completion: nil)
    }
        

}

class  MyLiveStreamUIView: UZLiveStreamUIView {
    
    
    
    override init() {
        super.init()
        //add custom UI here
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //customize layout here
    }
    
    override func onButtonSelected(_ button: UIButton) {
        print("\(button.currentTitle)")
    }
}
