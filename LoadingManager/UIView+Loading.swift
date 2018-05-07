//
//  UIView+Loading.swift
//  EDUAdmin
//
//  Created by Lin Sheng on 2018/5/2.
//  Copyright © 2018年 XRJ. All rights reserved.
//

import UIKit

extension UIView {
    
    public func setLoadingSuccess(animated: Bool = false, withDuration: TimeInterval = 0.3) {
        LoadingManager.setLoadingSuccess(inView: self, animated: animated, withDuration: withDuration)
    }
    
    public func setLoadingStart() {
        LoadingManager.setLoadingStart(inView: self)
    }
    
    public func setLoadingFailed(retryHandle: (() -> Void)?) {
        LoadingManager.setLoadingFailed(inView: self, retryHandle: retryHandle)
    }
    
    @discardableResult
    public func setLoadingFailedIfIsLoading(retryHandle: (() -> Void)?) -> Bool {
        return LoadingManager.setLoadingFailedIfIsLoading(inView: self, retryHandle: retryHandle)
    }
}
