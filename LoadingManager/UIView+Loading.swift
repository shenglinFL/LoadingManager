//
//  UIView+Loading.swift
//  EDUAdmin
//
//  Created by Lin Sheng on 2018/5/2.
//  Copyright © 2018年 XRJ. All rights reserved.
//

import UIKit

private var _loadingRetryHandleKey = 0

extension UIView {
    
    public var loadingRetryHandle: LoadingManagerFailedRetryHandle? {
        get {
            return objc_getAssociatedObject(self, &_loadingRetryHandleKey) as? LoadingManagerFailedRetryHandle
        }
        set {
            objc_setAssociatedObject(self, &_loadingRetryHandleKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    public func setLoadingSuccess(animated: Bool = false, withDuration: TimeInterval = 0.3) {
        LoadingManager.setLoadingSuccess(inView: self, animated: animated, withDuration: withDuration)
    }
    
    public func setLoadingStart() {
        LoadingManager.setLoadingStart(inView: self)
    }
    
    /// 当有retryHandle，且retryHandle != nil时，执行retryHandle。否则执行loadingRetryHandle属性block
    ///
    /// - Parameter retryHandle: LoadingManagerFailedRetryHandle
    public func setLoadingFailed(retryHandle: LoadingManagerFailedRetryHandle? = nil) {
        if (retryHandle != nil) {
            LoadingManager.setLoadingFailed(inView: self, retryHandle: retryHandle)
            return
        }
        LoadingManager.setLoadingFailed(inView: self, retryHandle: self.loadingRetryHandle)
    }
    
    /// 当有retryHandle，且retryHandle != nil时，执行retryHandle。否则执行loadingRetryHandle属性block
    ///
    /// - Parameter retryHandle: LoadingManagerFailedRetryHandle
    /// - Returns: 是否显示失败视图
    @discardableResult
    public func setLoadingFailedIfIsLoading(retryHandle: LoadingManagerFailedRetryHandle? = nil) -> Bool {
        if (retryHandle != nil) {
            return LoadingManager.setLoadingFailedIfIsLoading(inView: self, retryHandle: retryHandle)
        }
        return LoadingManager.setLoadingFailedIfIsLoading(inView: self, retryHandle: self.loadingRetryHandle)
    }
}
