//
//  LoadingView.swift
//  EDUAdmin
//
//  Created by Lin Sheng on 2018/5/2.
//  Copyright © 2018年 XRJ. All rights reserved.
//

import UIKit
import SnapKit

enum LoadingViewType {
    case normal // same as theme
    case theme
}

class LoadingView: UIView {
    
    private let _loadingViewType: LoadingViewType
    
    private let _animateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.animationImages = LoadingManager.loadingImages
        imageView.animationDuration = LoadingManager.loadingAnimationDuration
        imageView.contentMode = .center
        imageView.image = LoadingManager.loadingDefaultImage
        return imageView
    }()
    
    private let _bgImageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = LoadingManager.loadingBackgroundImage
        imageView.contentMode = .center
        return imageView
    }()
    
    init(loadingViewType: LoadingViewType) {
        _loadingViewType = loadingViewType
        super.init(frame: CGRect.zero)
        
        self.addSubview(_bgImageView)
        self.addSubview(_animateImageView)
        
        _bgImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        _animateImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        
        self.backgroundColor = LoadingManager.backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func showLoading(inView: UIView, type: LoadingViewType) {
        let loadingView = LoadingView(loadingViewType: type)
        loadingView.showLoading(inView: inView, type: type)
    }
    
    func showLoading(inView: UIView, type: LoadingViewType) {
        if LoadingView.loading(inView: inView) != nil {
            return
        }
        if self.superview != inView {
            self.removeFromSuperview()
            inView.addSubview(self)
            inView.bringSubviewToFront(self)
            
            self.frame = inView.bounds
            
            _animateImageView.startAnimating()
        }
    }
    
    static func hideLoadingWithAnimation(inView: UIView, animated: Bool = false, withDuration: TimeInterval = 0.3)  {
        if let loadingView = LoadingView.loading(inView: inView) {
            if animated {
                loadingView.hideLoadingWithAnimation(withDuration: withDuration)
            }else {
                loadingView.hideLoadingNoAnimation()
            }
        }
    }
    
    func hideLoadingWithAnimation(withDuration: TimeInterval = 0.3) {
        self.alpha = 1.0
        UIView.animate(withDuration: withDuration, animations: {
            self.alpha = 0
        }) { (finished) in
            self.hideLoadingNoAnimation()
        }
    }
    
    func hideLoadingNoAnimation() {
        self._animateImageView.stopAnimating()
        self.removeFromSuperview()
    }
    
    static func loading(inView: UIView) -> LoadingView?{
        for view in inView.subviews.reversed() {
            if let v = view as? LoadingView {
                return v
            }
        }
        return nil
    }
    
    static func isLoading(inView: UIView) -> Bool {
        if LoadingView.loading(inView: inView) != nil {
            return true
        }
        return false
    }
}
