//
//  DemoViewController.swift
//  LoadingManagerExample
//
//  Created by Lin Sheng on 2018/5/4.
//  Copyright © 2018年 linsheng. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .gray
        
        self.setLoadingStart()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.setLoadingFailedIfIsLoading(retryHandle: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.retry()
            })
        }
    }
    
    private func retry() {
        self.setLoadingStart()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.setLoadingSuccess()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
