//
//  VButton.swift
//  VryLibrary
//
//  Created by Ryan Raj on 3/9/22.
//

import UIKit
import SnapKit

public enum VryButtonStyle {
    case filled, text
}

public enum VryButtonType {
    case primary, secondary, cancel, delete
}


open class VryButton: UIButton {
    // MARK: Public API
    ///Shows in-button indicator AND disables
    override public func showLoadingDots(color: UIColor = .white, withBackdrop: Bool = false, opacity: Float = 0.4, retries: Int = 4) {
        self.titleLabel?.alpha = 0
        self.isEnabled = false

        super.showLoadingDots(color: color, withBackdrop: withBackdrop)
    }
    
    ///Hides in-button indicator AND enables
    override public func hideLoadingDots() {
        self.isEnabled = true
        self.titleLabel?.alpha = 1

        super.hideLoadingDots()
    }
    
    // MARK: Inits
    public init(_ text: String?,
         style: VryButtonStyle = .filled,
         type: VryButtonType = .primary) {
        self.style = style
        self.type = type
        self.text = text
        
        super.init(frame: .zero)
        
        setTitle(text, for: .normal)
        
        setup()
    }
    required public init?(coder: NSCoder) { return nil }

    private func setup() {
        configureButton()
    }
    
    private var style: VryButtonStyle
    private var type: VryButtonType
    private var text: String?
//    private var textColor: LabelColor
    
    
    public func setBackgroundColor(color: UIColor, forState: UIControl.State) {
            self.clipsToBounds = true  // add this to maintain corner radius
            UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
            if let context = UIGraphicsGetCurrentContext() {
                context.setFillColor(color.cgColor)
                context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
                let colorImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                self.setBackgroundImage(colorImage, for: forState)
            }
        }
    
    private func configureButton() {
        self.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        layer.cornerRadius = 20
        layer.masksToBounds = false
        
        
//        self.clipsToBounds = true
        if let text = text {
            titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 13)!//UIFont(name: "AvenirNext-DemiBold", size: size)
            setTitle(text.localizedUppercase, for: .normal)
        }
        
        
        switch style {
            case .filled:
                configureFilledButton()
//                applyContainedTheme(withScheme: Material.shared.container)
            case .text:
                configureTextButton()
//                applyTextTheme(withScheme: Material.shared.container)
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

        if style == .text {
//            setBackgroundColor(.clear, for: .disabled)
        }

        //custom disabled state
//        setTitleColor(textColor.color, for: .normal)
//        setTitleColor(textColor.color.withAlphaComponent(0.75), for: .disabled)
//
//        minimumSize = CGSize(width: 64, height: 40)
    }
    
    private func configureTextButton() {
        setBackgroundColor(color: .clear, forState: .normal)
        setTitleColor(.black, for: .normal)
    }
    
    private func configureFilledButton() {
        setBackgroundColor(color: hexStringToUIColor(hex: "#1F81C3"), forState: .normal) //
//        setImage(download_icon, for: .normal)
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        self.layer.shadowOpacity = 0.5
//        self.layer.cornerRadius = 14
//        setImage(UIImage.named(.vaultLogo), for: .normal)
//        let shadowLayer = CAShapeLayer()
//        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
//        shadowLayer.fillColor = UIColor.white.cgColor
//
//        shadowLayer.shadowColor = UIColor.darkGray.cgColor
//        shadowLayer.shadowPath = shadowLayer.path
//        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        shadowLayer.shadowOpacity = 0.8
//        shadowLayer.shadowRadius = 2
//
//        layer.insertSublayer(shadowLayer, at: 0)
//        self.layer.masksToBounds = false
//                self.layer.cornerRadius = self.frame.height/2
//                self.layer.shadowColor = UIColor.black.cgColor
//                self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
//                self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//                self.layer.shadowOpacity = 0.5
//                self.layer.shadowRadius = 1.0
//        self.layer.shadowRadius = 5
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSize(width: 0, height: 1)
//        self.layer.masksToBounds = false
//        self.clipsToBounds = true
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.green.cgColor
//        self.layer.shadowOffset = CGSize(width: 10, height: 30)
//        self.layer.shadowRadius = 5.0
//        self.layer.shadowOpacity = 1
//        addShadow()
        
        
    }
    
    func addShadow(offset: CGSize = CGSize(width: 0, height: 3)) {
//        layer.shadowOffset = offset
//        layer.shadowRadius = 5
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.4
//        layer.masksToBounds = false
        let shadowLayer = CAShapeLayer()
           
           layer.cornerRadius = 20
           shadowLayer.path = UIBezierPath(roundedRect: bounds,
                                           cornerRadius: layer.cornerRadius).cgPath
           shadowLayer.fillColor = backgroundColor?.cgColor
           shadowLayer.shadowColor = UIColor.darkGray.cgColor
           shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
           shadowLayer.shadowOpacity = 0.4
           shadowLayer.shadowRadius = 5.0
           layer.insertSublayer(shadowLayer, at: 1)
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
    
    private  var podsBundle: Bundle {
        let bundle = Bundle(for: self.classForCoder)
            return Bundle(url: bundle.url(forResource: "VryPod",
                                          withExtension: "bundle")!)!
        }

        private  func imageFor(name imageName: String) -> UIImage {
            return UIImage.init(named: imageName, in: podsBundle, compatibleWith: nil)!
        }

        public  var download_icon: UIImage {
//            return .named(.vaultLogoWhite, bundle: podsBundle)//imageFor(name: "vault-logo-white")
            let podbundle = Bundle(for: VryButton.self) // for getting pod url
                if let url = podbundle.url(forResource: "PodBundle", withExtension: "bundle") { //<YourBundleName> must be the same as you wrote in .podspec
                    let bundle = Bundle(url: url)
                    return UIImage(named: "Vault_Logo_WHT", in: bundle, compatibleWith: nil)!
                }
                return UIImage()
        }
}
