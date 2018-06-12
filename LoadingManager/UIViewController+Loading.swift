//
//  UIViewController+Loading.swift
//  EDUAdmin
//
//  Created by Lin Sheng on 2018/5/2.
//  Copyright © 2018年 XRJ. All rights reserved.
//

import UIKit

private var _loadingRetryHandleKey = 0

public extension UIViewController {
    
    public var loadingRetryHandle: LoadingManagerFailedRetryHandle? {
        get {
            return objc_getAssociatedObject(self, &_loadingRetryHandleKey) as? LoadingManagerFailedRetryHandle
        }
        set {
            objc_setAssociatedObject(self, &_loadingRetryHandleKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    public func setLoadingSuccess(animated: Bool = false, withDuration: TimeInterval = 0.3) {
        LoadingManager.setLoadingSuccess(inView: self.view, animated: animated, withDuration: withDuration)
    }
    
    public func setLoadingStart() {
        LoadingManager.setLoadingStart(inView: self.view)
    }
    
    /// 当有retryHandle，且retryHandle != nil时，执行retryHandle。否则执行loadingRetryHandle属性block
    ///
    /// - Parameter retryHandle: LoadingManagerFailedRetryHandle
    public func setLoadingFailed(retryHandle: LoadingManagerFailedRetryHandle? = nil) {
        if (retryHandle != nil) {
            LoadingManager.setLoadingFailed(inView: self.view, retryHandle: retryHandle)
            return
        }
        LoadingManager.setLoadingFailed(inView: self.view, retryHandle: self.loadingRetryHandle)
    }
    
    /// 当有retryHandle，且retryHandle != nil时，执行retryHandle。否则执行loadingRetryHandle属性block
    ///
    /// - Parameter retryHandle: LoadingManagerFailedRetryHandle
    /// - Returns: 是否显示失败视图
    @discardableResult
    public func setLoadingFailedIfIsLoading(retryHandle: LoadingManagerFailedRetryHandle? = nil) -> Bool {
        if (retryHandle != nil) {
            return LoadingManager.setLoadingFailedIfIsLoading(inView: self.view, retryHandle: retryHandle)
        }
        return LoadingManager.setLoadingFailedIfIsLoading(inView: self.view, retryHandle: self.loadingRetryHandle)
    }
}
