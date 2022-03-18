//
//  VButton.swift
//  VryLibrary
//
//  Created by Ryan Raj on 3/9/22.
//

import UIKit
import SnapKit
import RippleAnimation

public enum VButtonStyle {
    case filled, text
}

public enum VButtonType {
    case primary, secondary, cancel, delete
}


open class VButton: UIButton {
    // MARK: Public API
    ///Shows in-button indicator AND disables
    override public func showLoadingDots(color: UIColor = .white, withBackdrop: Bool = false, opacity: Float = 0.4, retries: Int = 4) {
        self.titleLabel?.alpha = 0
        self.isEnabled = false
        if style == .text {
            super.showLoadingDots(color: hexStringToUIColor(hex: "#1F81C3"), withBackdrop: withBackdrop)
        } else {
            super.showLoadingDots(color: color, withBackdrop: withBackdrop)
        }
    }
    
    ///Hides in-button indicator AND enables
    override public func hideLoadingDots() {
        self.isEnabled = true
        self.titleLabel?.alpha = 1
        setBackgroundColor(color: hexStringToUIColor(hex: "#1F81C3"), forState: .normal)
        super.hideLoadingDots()
    }
    
     public func addTarget(action: @escaping () -> Void, for controlEvents: UIControl.Event) {
         self.action = action
         super.addTarget(self, action: #selector(buttonAction), for: controlEvents)
    }
    
    @objc func buttonAction() {
        guard let action = action else {
            return
        }
        self.rippleAnimate(
            color: hexStringToUIColor(hex: "#78B3DB"),
            completionHandler: { [unowned self] in
                self.setBackgroundColor(color: hexStringToUIColor(hex: "#1F81C3"), forState: .disabled)
//                self.showLoadingDots()
                action()
            }
        )
    }
    
    override open var isEnabled: Bool {
        didSet {
            self.setBackgroundColor(color: hexStringToUIColor(hex: "#1F81C3"), forState: .disabled)
            super.isEnabled = isEnabled
        }
    }
    
    // MARK: Inits
    public init(_ text: String?,
         style: VButtonStyle = .filled,
         type: VButtonType = .primary,
         textColor: UIColor = .white
    ) {
        self.style = style
        self.type = type
        self.text = text
        self.textColor = textColor
        super.init(frame: .zero)
        
        setTitle(text, for: .normal)
        
        setup()
    }
    required public init?(coder: NSCoder) { return nil }

    private func setup() {
        configureButton()
    }
    
    private var style: VButtonStyle
    private var type: VButtonType
    private var text: String?
    private var action: (() -> Void)?
    private var textColor: UIColor
    
    
    public func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.layer.masksToBounds = false
        if style == .filled {
            switch forState {
                case .normal:
                    self.backgroundColor =  color
                    self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
                    self.layer.shadowOpacity = 0.5
                case .disabled:
                    self.backgroundColor = color.withAlphaComponent(0.75)
                    self.layer.shadowOpacity = 0
                default: self.backgroundColor = color
            }
        } else {
            switch forState {
                case .disabled:
                    self.backgroundColor = hexStringToUIColor(hex: "#1F81C3")//.clear//default: self.backgroundColor = .clear
                default: self.backgroundColor = .clear
            }
        }
    }
    
    private func configureButton() {
        self.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(40)
            $0.width.greaterThanOrEqualTo(64)
        }
        
        
        if let text = text {
            titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 14) //UIFont(name: "AvenirNext-DemiBold", size: 13)!//UIFont(name: "AvenirNext-DemiBold", size: size)
            setTitle(text.localizedUppercase, for: .normal)
        }
        
        
        switch style {
            case .filled:
                configureFilledButton()
            case .text:
                configureTextButton()
        }

//        if style == .filled {
//            switch type {
//                case .primary:
//                    setBackgroundColor(
//                        VBlue.normal.color,
//                        for: .normal
//                    )
//                case .secondary:
//                    setBackgroundColor(
//                        VPurple.normal.color,
//                        for: .normal
//                    )
//                case .cancel:
//                    setBackgroundColor(
//                        VGrey.normal.color,
//                        for: .normal
//                    )
//                case .delete:
//                    setBackgroundColor(
//                        VRed.normal.color,
//                        for: .normal
//                    )
//            }
//        }
        
        setTitleColor(textColor, for: .normal)
        setTitleColor(textColor.withAlphaComponent(0.75), for: .disabled)

    }
    
    private func configureTextButton() {
        setBackgroundColor(color: .clear, forState: .normal)
//        setBackgroundColor(color: hexStringToUIColor(hex: "#1F81C3"), forState: .highlighted)
        let titleColor = hexStringToUIColor(hex: "#1F81C3")
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor.withAlphaComponent(0.75), for: .disabled)
    }
    
    private func configureFilledButton() {
        setBackgroundColor(color: hexStringToUIColor(hex: "#1F81C3"), forState: .normal)
        self.layer.cornerRadius = 2
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
