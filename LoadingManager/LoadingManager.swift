//
//  LoadingManager.swift
//  EDUAdmin
//
//  Created by Lin Sheng on 2018/5/2.
//  Copyright © 2018年 XRJ. All rights reserved.
//

import UIKit

enum LoadingState {
    case normal
    case loading
    case failure
}

class LoadingManager: NSObject {
    
    static var loadingImages: [UIImage]?
    static var loadingDefaultImage: UIImage?
    static var loadingBackgroundImage: UIImage?
    
    static var loadFailedImage: UIImage?
    static var loadFailedTitle: String?
    static var loadFailedContent: String?
    
    
    public static func setLoadingConfig(loadingImages: [UIImage]?, loadingDefaultImage: UIImage?, loadingBackgroundImage: UIImage?) {
        LoadingManager.loadingImages = loadingImages
        LoadingManager.loadingDefaultImage = loadingDefaultImage
        LoadingManager.loadingBackgroundImage = loadingBackgroundImage
    }
    
    public static func setLoadFailedConfig(image: UIImage?, title: String?, content: String?) {
        LoadingManager.loadFailedImage = image
        LoadingManager.loadFailedTitle = title
        LoadingManager.loadFailedContent = content
    }
    
    private func setLoadingState(inView: UIView ,state: LoadingState) {
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
    public static func setLoadingSuccess(inView: UIView) {
        LoadingView.hideLoadingWithAnimation(inView: inView, animated: false)
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
    static func setLoadingFailedIfIsLoading(inView: UIView, retryHandle: (() -> Void)?) -> Bool {
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
    static func isLoading(inView: UIView) -> Bool{
        return LoadingView.isLoading(inView: inView)
    }
}

