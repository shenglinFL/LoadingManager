//
//  UIView+Loading.swift
//  EDUAdmin
//
//  Created by Lin Sheng on 2018/5/2.
//  Copyright © 2018年 XRJ. All rights reserved.
//

import UIKit

extension UIView {
    
    func setLoadingSuccess() {
        LoadingManager.setLoadingSuccess(inView: self)
    }
    
    func setLoadingStart() {
        LoadingManager.setLoadingStart(inView: self)
    }
    
    func setLoadingFailed(retryHandle: (() -> Void)?) {
        LoadingManager.setLoadingFailed(inView: self, retryHandle: retryHandle)
    }
    
    @discardableResult
    func setLoadingFailedIfIsLoading(retryHandle: (() -> Void)?) -> Bool {
        return LoadingManager.setLoadingFailedIfIsLoading(inView: self, retryHandle: retryHandle)
    }
}
