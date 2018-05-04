//
//  UIViewController+Loading.swift
//  EDUAdmin
//
//  Created by Lin Sheng on 2018/5/2.
//  Copyright © 2018年 XRJ. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public func setLoadingSuccess() {
        LoadingManager.setLoadingSuccess(inView: self.view)
    }
    
    public func setLoadingStart() {
        LoadingManager.setLoadingStart(inView: self.view)
    }
    
    public func setLoadingFailed(retryHandle: (() -> Void)?) {
        LoadingManager.setLoadingFailed(inView: self.view, retryHandle: retryHandle)
    }
    
    @discardableResult
    public func setLoadingFailedIfIsLoading(retryHandle: (() -> Void)?) -> Bool {
        return LoadingManager.setLoadingFailedIfIsLoading(inView: self.view, retryHandle: retryHandle)
    }
}
