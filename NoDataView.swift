//
//  NoDataView.swift
//  VryLibrary
//
//  Created by Ryan Raj on 3/18/22.
//

import UIKit

class NoDataView: UIView {
    // MARK: Public API
    public var icon: UIImage? = nil { didSet { iconView.image = icon } }

    public var iconColor: UIColor? = ThemeColorText.greyv1.color { didSet { iconView.tintColor = iconColor } }

    public var titleText: String? = nil { didSet { titleLabel.text = titleText } }

    public var messageText: String? = nil { didSet { messageLabel.text = messageText } }

    public var action: NoDataAction? {
        didSet {
            if action != nil {
                actionButton.setTitle(action?.title, for: .normal)
                actionButton.snp.remakeConstraints {
                    $0.top.equalTo(messageLabel.snp.bottom).offset(15)
                    $0.left.right.equalTo(titleLabel)
                }
            }
        }
    }

    // MARK: Inits
    init(title: String? = nil,
         message: String? = nil,
         icon: UIImage? = nil,
         iconColor: UIColor? = nil,
         action: NoDataAction? = nil) {
        self.action = action
        super.init(frame: .zero)

        self.titleText = title
        self.messageText = message
        self.icon = icon
        self.iconColor = iconColor

        setup()
    }
    required init?(coder: NSCoder) { return nil }

    private func setup() {
        backgroundColor = ThemeColorFill.background.color

        constrain()
    }

    private func constrain() {
        iconView.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.centerY).offset(-15)
            $0.centerX.equalTo(self)
            $0.width.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(10)
            $0.centerX.equalTo(self)
            $0.width.equalTo(self).multipliedBy(0.75)
        }
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(self)
            $0.width.equalTo(self).multipliedBy(0.75)
        }
        if action != nil {
            actionButton.snp.makeConstraints {
                $0.top.equalTo(messageLabel.snp.bottom).offset(15)
                $0.left.right.equalTo(titleLabel)
            }
        }
    }

    // MARK: Overrides

    // MARK: Private Members
    @objc private func buttonTapped() {
        action?.action()
    }

    // MARK: Lazy Loads
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = iconColor ?? ThemeColorText.greyv1.color
        addSubview(imageView)
        return imageView
    }()
    private lazy var titleLabel: VryLabel = {
        let label = VryLabel(titleText, type: .headline1, textColor: .greyv1, align: .center, numLines: 0)
        addSubview(label)
        return label
    }()
    private lazy var messageLabel: VryLabel = {
        let label = VryLabel(messageText, type: .body1, textColor: .greyv1, align: .center, numLines: 0)
        addSubview(label)
        return label
    }()
    private lazy var actionButton: VButton = {
        let button = VButton(action?.title)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addSubview(button)
        return button
    }()
}
