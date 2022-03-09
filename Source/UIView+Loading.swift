//
//  UIView+Loading.swift
//  VryLibrary
//
//  Created by Ryan Raj on 3/9/22.
//

import UIKit

public extension UIView {
    @objc func showLoadingDots(
        color: UIColor = UIColor.blue,
        withBackdrop: Bool = true,
        opacity: Float = 0.4,
        retries: Int = 4
    ) {
        guard bounds.size != .zero else {
            setNeedsLayout()
            layoutIfNeeded()
            DispatchQueue.main.asyncAfter(
                deadline: .now() + .milliseconds(100)
            ) {
                if retries > 0 {
                    self.showLoadingDots(
                        color: color,
                        withBackdrop: withBackdrop,
                        opacity: opacity,
                        retries: retries - 1
                    )
                }
            }
            return
        }

        isUserInteractionEnabled = false

        if withBackdrop {
            layer.addSublayer(
                LoadingBackground(
                    parentFrame: CGRect(origin: .zero, size: bounds.size),
                    opacity: opacity)
            )
        }

        let loadingLayer = LoadingLayer(
            parentFrame: CGRect(origin: .zero, size: bounds.size),
            color: color
        )
        layer.addSublayer(loadingLayer)
    }

    @objc func hideLoadingDots() {
        isUserInteractionEnabled = true
        if let sublayers = layer.sublayers {
            for sublayer in sublayers {
                if sublayer is LoadingLayer || sublayer is LoadingBackground {
                    sublayer.removeAllAnimations()
                    sublayer.removeFromSuperlayer()
                }
            }
        }
    }
}

class LoadingBackground: CALayer {

    init(parentFrame: CGRect, opacity: Float) {
        super.init()
        backgroundColor = UIColor.black.cgColor
        self.opacity = opacity
        frame = parentFrame
    }
    override init(layer: Any) {
        super.init(layer: layer)
    }
    required init?(coder: NSCoder) { return nil }
}

class LoadingLayer: CAReplicatorLayer {

    // MARK: Inits
    init(parentFrame: CGRect, color: UIColor) {
        self.parentFrame = parentFrame
        self.color = color
        super.init()
        setup()
    }

    override init(layer: Any) {
        if let layer = layer as? LoadingLayer {
            self.parentFrame = layer.parentFrame
            self.color = layer.color
        } else {
            self.parentFrame = .zero
            self.color = UIColor.green
        }
        super.init(layer: layer)
    }

    required init?(coder: NSCoder) { nil }

    private func setup() {
        circleLayer.fillColor = color.cgColor
        circleLayer.path = UIBezierPath(
            ovalIn: CGRect(
                origin: .zero,
                size: CGSize(
                    width: dotSize,
                    height: dotSize
                )
            )
        ).cgPath
        circleLayer.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: dotSize,
                height: dotSize
            )
        )
        let allDotsWidth = (dotSize * dotCount) + (dotSpacing * (dotCount - 1))
        let x = (parentFrame.width / 2) - (allDotsWidth / 2)
        let y = (parentFrame.height / 2) - (dotSize / 2)

        instanceTransform = CATransform3DMakeTranslation(
            CGFloat(dotSize + dotSpacing), 0, 0
        )
        frame = CGRect(x: x, y: y, width: allDotsWidth, height: dotSize)

        instanceCount = Int(dotCount)
        addSublayer(circleLayer)

        let scaleAnim = CAKeyframeAnimation(
            keyPath: "transform.scale" //i18n-ignore
        )
        scaleAnim.keyTimes = [0, 0.3, 0.7]
        scaleAnim.values = [0, 1, 0]
        scaleAnim.repeatCount = .infinity
        scaleAnim.fillMode = .backwards
        scaleAnim.timingFunctions = [
            .init(name: .easeInEaseOut),
            .init(name: .easeInEaseOut),
            .init(name: .easeInEaseOut)
        ]
        scaleAnim.duration = 2 / animationSpeed

        instanceDelay = 0.2
        circleLayer.add(scaleAnim, forKey: "loadIndicator") //i18n-ignore
    }

    // MARK: Private members
    private let parentFrame: CGRect
    private let color: UIColor

    private var dotSize: CGFloat = 15
    private var dotSpacing: CGFloat = 0
    private var dotCount: CGFloat = 3
    private var animationSpeed: Double = 1.5

    private var circleLayer = CAShapeLayer()
}


