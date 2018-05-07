//
//  LoadingManager.swift
//  EDUAdmin
//
//  Created by Lin Sheng on 2018/5/2.
//  Copyright © 2018年 XRJ. All rights reserved.
//

import UIKit

public enum LoadingState {
    case normal
    case loading
    case failure
}

public class LoadingManager: NSObject {

    static var loadingImages: [UIImage]?
    static var loadingDefaultImage: UIImage? // 家长动图展位图(iOS10以下动图禁止时显示）
    static var loadingBackgroundImage: UIImage?
    static var loadingAnimationDuration: TimeInterval = 0.0
    
    static var loadFailedImage: UIImage?

    static var loadFailedTitleText: NSAttributedString?
    static var loadFailedContentText: NSAttributedString?
    
    public static var backgroundColor: UIColor = .white

    public static func setLoadingConfig(loadingImages: [UIImage]?, loadingDefaultImage: UIImage?, loadingBackgroundImage: UIImage?, loadingAnimationDuration: TimeInterval = 0.0) {
        LoadingManager.loadingImages = loadingImages
        LoadingManager.loadingDefaultImage = loadingDefaultImage
        LoadingManager.loadingBackgroundImage = loadingBackgroundImage
        LoadingManager.loadingAnimationDuration = loadingAnimationDuration
    }
    
    public static func setLoadFailedConfig(image: UIImage?, title: NSAttributedString?, content: NSAttributedString?) {
        LoadingManager.loadFailedImage = image
        LoadingManager.loadFailedTitleText = title
        LoadingManager.loadFailedContentText = content
    }
    
    private func setLoadingState(inView: UIView ,state: LoadingState) { // 弃用
        switch state {
        case .normal:
            LoadingView.showLoading(inView: inView, type: .normal)
            LoadFailedView.hideLoadFailedViewWithAnimation(inView: inView)
        case .loading:
            LoadFailedView.hideLoadFailedViewWithAnimation(inView: inView)
            LoadingView.showLoading(inView: inView, type: .normal)
        case .failure:
            LoadingView.hideLoadingWithAnimation(inView: inView)
            // 添加失败页
            LoadFailedView.showLoadFailedView(inView: inView, retryHandle: nil)
        }
    }
    
    /// 结束Loading（成功）
    ///
    /// - Parameter inView: UIView
    public static func setLoadingSuccess(inView: UIView, animated: Bool = false, withDuration: TimeInterval = 0.3) {
        LoadingView.hideLoadingWithAnimation(inView: inView, animated: animated, withDuration: withDuration)
        LoadFailedView.hideLoadFailedViewNoAnimation(inView: inView)
    }
    
    /// 开始Loading
    ///
    /// - Parameter inView: UIView
    public static func setLoadingStart(inView: UIView) {
        LoadFailedView.hideLoadFailedViewNoAnimation(inView: inView)
        LoadingView.showLoading(inView: inView, type: .normal)
    }
    
    /// 结束Loading（失败）
    ///
    /// - Parameters:
    ///   - inView: UIView
    ///   - retryHandle: 点击刷新回调
    public static func setLoadingFailed(inView: UIView, retryHandle: (() -> Void)?) {
        LoadingView.hideLoadingWithAnimation(inView: inView)
        // 添加失败页
        LoadFailedView.showLoadFailedView(inView: inView, retryHandle: retryHandle)
    }
    
    /// 当在Loading时，显示失败视图，否则不显示失败视图
    ///
    /// - Parameters:
    ///   - inView: UIView
    ///   - retryHandle: 点击刷新回调
    /// - Returns: 是否显示失败视图
    @discardableResult
    public static func setLoadingFailedIfIsLoading(inView: UIView, retryHandle: (() -> Void)?) -> Bool {
        if LoadingManager.isLoading(inView: inView) {
            LoadingManager.setLoadingFailed(inView: inView, retryHandle: retryHandle)
            return true
        }
        return false
    }
    
    /// 是否在Loading
    ///
    /// - Parameter inView: UIView
    /// - Returns: 是否在Loading
    public static func isLoading(inView: UIView) -> Bool{
        return LoadingView.isLoading(inView: inView)
    }
}


