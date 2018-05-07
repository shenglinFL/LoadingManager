//
//  LoadFailedView.swift
//  EDUAdmin
//
//  Created by Lin Sheng on 2018/5/2.
//  Copyright © 2018年 XRJ. All rights reserved.
//

import UIKit

class LoadFailedView: UIView {
    
    /// 图片
    private let _failedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = LoadingManager.loadFailedImage
        return imageView
    }()
    
    /// 标题
    private let _failedTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    /// 详情
    private let _failedContentLabel: UILabel = { // MARK: 暂未使用到
        let label = UILabel()
        return label
    }()
    
    private var _canTouchRefresh: Bool = true
    
    private var _retryHandler: (() -> Void)?
    
    private let _contentView = UIView()
    
    init(title: NSAttributedString? = LoadingManager.loadFailedTitleText, content: NSAttributedString? = LoadingManager.loadFailedContentText, canTouchRefresh: Bool = true) {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = LoadingManager.backgroundColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(retry))
        self.addGestureRecognizer(tap)
        
        _failedTitleLabel.attributedText = title
        _failedContentLabel.attributedText = content
        _canTouchRefresh = canTouchRefresh
        
        self.addSubview(_contentView)
        _contentView.addSubview(_failedImageView)
        _contentView.addSubview(_failedTitleLabel)
        _contentView.addSubview(_failedContentLabel)
        
        _failedImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        _failedTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(_failedImageView.snp.bottom).offset(8)
        }
        _failedContentLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(_failedTitleLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
        _contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been impl@objc emented")
    }
    
    @objc private func retry() {
        _retryHandler?()
    }
    
    static func showLoadFailedView(inView: UIView, retryHandle: (() -> Void)?) {
        let loadFailedView = LoadFailedView()
        loadFailedView.showLoadFailedView(inView: inView, retryHandle: retryHandle)
    }
    
    func showLoadFailedView(inView: UIView, retryHandle: (() -> Void)?) {
        _retryHandler = retryHandle
        showFailedView(inView: inView)
    }
    
    static func hideLoadFailedViewWithAnimation(inView: UIView)  {
        if let loadingView = LoadFailedView.loadFailedView(forView: inView) {
            loadingView.hideLoadFailedViewWithAnimation()
        }
    }
    
    func hideLoadFailedViewWithAnimation() {
        self.alpha = 1.0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (finished) in
            self.hideLoadFailedViewNoAnimation()
        }
    }
    
    static func hideLoadFailedViewNoAnimation(inView: UIView) {
        if let loadFailedView = LoadFailedView.loadFailedView(forView: inView) {
            loadFailedView.hideLoadFailedViewNoAnimation()
        }
    }
    
    func hideLoadFailedViewNoAnimation() {
        self.removeFromSuperview()
    }
    
    static func loadFailedView(forView: UIView) -> LoadFailedView? {
        for view in forView.subviews.reversed() {
            if let v = view as? LoadFailedView {
                return v
            }
        }
        return nil
    }
    
    private func showFailedView(inView: UIView){
        if LoadFailedView.loadFailedView(forView: inView) != nil {
            return
        }
        if self.superview != inView {
            self.removeFromSuperview()
            inView.addSubview(self)
            inView.bringSubview(toFront: self)
            self.frame = inView.bounds
        }
    }
}
