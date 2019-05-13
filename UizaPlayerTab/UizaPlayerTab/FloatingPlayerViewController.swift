//
//  FloatingPlayerViewController.swift
//  UizaPlayerTab
//
//  Created by le anh duc on 5/8/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit
import UizaSDK
import FrameLayoutKit

class FloatingPlayerViewController: UZFloatingPlayerViewController {

    static public var currentInstance: FloatingPlayerViewController? = nil
    
    fileprivate let titleLabel = UILabel()
    fileprivate let detailsLabel = UILabel()
    fileprivate let scrollView = UIScrollView()
    fileprivate var frameLayout: StackFrameLayout!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init() {
        super.init()
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        detailsLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        detailsLabel.numberOfLines = 0
        detailsLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(detailsLabel)
        frameLayout = StackFrameLayout(direction: .vertical)
        frameLayout.append(view: titleLabel).edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        frameLayout.append(view: detailsLabel).edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        frameLayout.spacing = 20
        frameLayout.edgeInsets = UIEdgeInsets(top: 40, left: 10, bottom: 10, right: 10)
        scrollView.addSubview(frameLayout)
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.isDirectionalLockEnabled = true
    }
    
    override open func playResource(_ resource: UZPlayerResource) {
        super.playResource(resource)
        updateView()
    }
    
    func updateView(){
        guard let videoItem = videoItem else {return}
        titleLabel.text = videoItem.name
        detailsLabel.text = videoItem.details
        self.view.setNeedsLayout()
    }
    
    override public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.floatingHandler?.delegate = nil
        super.dismiss(animated: flag, completion: completion)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        FloatingPlayerViewController.currentInstance = self
        self.view.backgroundColor = UIColor(displayP3Red: 0.04, green: 0.06, blue: 0.12, alpha: 1.00)
        self.detailsContainerView.addSubview(scrollView)
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        FloatingPlayerViewController.currentInstance = nil
    }
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let viewSize = self.view.bounds
        let contentSize = frameLayout.sizeThatFits(CGSize(width: viewSize.width, height: CGFloat.infinity))
        frameLayout.frame = CGRect(x: 0, y: 0, width: viewSize.width, height: contentSize.height)
        scrollView.frame = detailsContainerView.bounds
        scrollView.contentSize = contentSize
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
