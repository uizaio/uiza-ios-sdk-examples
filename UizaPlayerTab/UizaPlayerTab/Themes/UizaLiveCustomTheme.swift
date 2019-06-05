//
//  UizaLiveCustomTheme.swift
//  UizaPlayerTab
//
//  Created by le anh duc on 5/20/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit
import UizaSDK
import FrameLayoutKit

class UizaLiveCustomTheme: UZLiveStreamUIView {
    
    internal var buttonFrameLayout: StackFrameLayout!
    
    override init(){
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        buttonFrameLayout = StackFrameLayout(direction: .horizontal, alignment: .left, views: [beautyButton, cameraButton])
        buttonFrameLayout.spacing = 10
        buttonFrameLayout.isIntrinsicSizeEnabled = true
        containerView.removeFromSuperview()
        self.addSubview(buttonFrameLayout)
        setupGestures()
        self.views = 0
    }
    
    override func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)
    }
    
    override func onTap(_ gesture: UITapGestureRecognizer) {
        if containerView.isHidden{
            print("Hidden")
            containerView.alpha = 0
            containerView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.containerView.alpha = 1.0
            })
        }else{
            print("View")
            UIView.animate(withDuration: 0.3, animations: {
                self.containerView.alpha = 0.0
            }, completion:  {(finished) in
                if finished{
                    self.containerView.isHidden = true
                }
            })
        }
    }
    
}
