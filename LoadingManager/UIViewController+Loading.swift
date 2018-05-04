//
//  UIViewController+Loading.swift
//  EDUAdmin
//
//  Created by Lin Sheng on 2018/5/2.
//  Copyright © 2018年 XRJ. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setLoadingSuccess() {
        LoadingManager.setLoadingSuccess(inView: self.view)
    }
    
    func setLoadingStart() {
        LoadingManager.setLoadingStart(inView: self.view)
    }
    
    func setLoadingFailed(retryHandle: (() -> Void)?) {
        LoadingManager.setLoadingFailed(inView: self.view, retryHandle: retryHandle)
    }
    
    @discardableResult
    func setLoadingFailedIfIsLoading(retryHandle: (() -> Void)?) -> Bool {
        return LoadingManager.setLoadingFailedIfIsLoading(inView: self.view, retryHandle: retryHandle)
    }
}
