//
//  ViewController.swift
//  VryLibrary
//
//  Created by ryanraj26 on 03/09/2022.
//  Copyright (c) 2022 ryanraj26. All rights reserved.
//

import UIKit
import VryLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setup() {
        
        customView.backgroundColor = UIColor.white
//        button.setBackgroundColor(UIColor.red, for: .normal)
//        button.setBackgroundColor(color: UIColor.blue, forState: .normal)
//        button.setBackgroundColor(color: UIColor.red, forState: .highlighted)
        
        
        button.snp.makeConstraints {
            $0.center.equalTo(customView)
            $0.width.equalTo(150)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        view = customView
    }
    
    @objc private func clicked() {
        button.showLoadingDots()
    }
    
    private lazy var customView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var button: VButton = {
        let button = VButton(nil)
//        button.isUserInteractionEnabled = true
        
//        button.setImage(UIImage.named(.vaultLogoWhite), for: .normal)
        button.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        customView.addSubview(button)
        return button
    }()

}

