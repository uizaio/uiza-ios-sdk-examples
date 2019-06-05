//
//  FloatingLiveViewController.swift
//  UizaPlayerTab
//
//  Created by le anh duc on 5/27/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit
import UizaSDK

public protocol FloatingLiveViewProtocol: class {
    func floatingLive(_ live:FloatingLiveViewController, didBecomeFloating: Bool)
    func floatingLive(_ live:FloatingLiveViewController, onFloatingProgress: CGFloat)
    func floatingPlayerDidDismiss(_ player: FloatingLiveViewController)
}

open class FloatingLiveViewController: UIViewController, NKFloatingViewHandlerProtocol  {
    
    static public var currentInstance: FloatingLiveViewController? = nil
    
    open var panGesture: UIPanGestureRecognizer! {
        get {
            return UIPanGestureRecognizer()
        }
    }
    
    open var fullRect: CGRect {
        get {
            return UIScreen.main.bounds
        }
    }
    
    open var gestureView: UIView!{
        get {
            return self.view!
        }
    }
    
    open var containerView: UIView!{
        get {
            return self.view.window!
        }
    }
    
    public var playerRatio: CGFloat = 9/16
//    public weak var delegate: FloatingLiveViewProtocol? = nil
//    public let detailsContainerView = UIView()
//    public private(set) var player: UZPlayer?
//
//    public var onDismiss: (() -> Void)? = nil
//    public var onFloatingProgress: ((FloatingLiveViewController, CGFloat) -> Void)? = nil
//    public var onFloating: ((FloatingLiveViewController) -> Void)? = nil
//    public var onUnFloating: ((FloatingLiveViewController) -> Void)? = nil
    
    public private(set) var floatingHandler: NKFloatingViewHandler?
    
    public init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func floatingRect(for position: NKFloatingPosition) -> CGRect {
        let screenSize = UIScreen.main.bounds.size
        let floatingWidth: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 180 : 220
        let floatingSize = CGSize(width: floatingWidth, height: floatingWidth * playerRatio)
        var point:CGPoint = .zero
        if position == .bottomRight{
            point = CGPoint(x: screenSize.width - floatingSize.width - 10, y: screenSize.height - floatingSize.height - 10)
        }else if position == .bottomLeft{
            point = CGPoint(x: 10, y: screenSize.height - floatingSize.height - 10)
        }else if position == .topLeft{
            point = CGPoint(x: 10, y: 10)
        }else if position == .topRight{
            point = CGPoint(x: screenSize.width - floatingSize.width - 10, y: 10)
        }
        return CGRect(origin: point, size: floatingSize)
    }
    
    public func floatingHandlerDidDragging(with progress: CGFloat) {
        
        
    }
    
    public func floatingHandlerDidDismiss() {
    }
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    open func stop(){
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
