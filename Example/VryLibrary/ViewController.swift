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
        button2.snp.makeConstraints {
            $0.top.bottom.equalTo(button)
            $0.left.equalTo(button.snp.right).offset(10)
            $0.width.equalTo(100)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        view = customView
    }
    
    private func clicked() {
        button.showLoadingDots()
        button2.hideLoadingDots()
        print("Maybe????")
    }
    
    private func clicked2() {
        button.hideLoadingDots()
        print("Maybe????")
    }
    
    private lazy var customView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var button: VButton = {
        let button = VButton("VryHello", style: .filled)
//        button.isUserInteractionEnabled = true
//        button.setBackgroundColor(color: ThemeColorFill.blue.color, forState: .normal)
//        button.setImage(UIImage.named(.vaultLogoWhite), for: .normal)
        button.isEnabled = false
        button.addTarget(action: clicked, for: .touchUpInside)
        customView.addSubview(button)
        return button
    }()
    
    private lazy var button2: VButton = {
        let button = VButton("Hello 2", style: .filled)
        button.addTarget(action: clicked2, for: .touchUpInside)
        customView.addSubview(button)
        return button
    }()

}

