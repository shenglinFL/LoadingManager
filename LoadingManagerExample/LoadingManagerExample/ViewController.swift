//
//  ViewController.swift
//  LoadingManagerExample
//
//  Created by Lin Sheng on 2018/5/4.
//  Copyright © 2018年 linsheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = .white
        
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        btn.setTitle("click", for: .normal)
        btn.center = self.view.center
        self.view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(test), for: .touchUpInside)
    }

    @objc private func test() {
        self.navigationController?.pushViewController(DemoViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

