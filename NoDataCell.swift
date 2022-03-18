//
//  NoDataCell.swift
//  VryLibrary
//
//  Created by Ryan Raj on 3/18/22.
//

import UIKit

struct NoDataAction {
    let title: String
    let action: () -> Void
}

class NoDataCell: UITableViewCell {
    // MARK: Public API

    // MARK: Inits
    init(
        title: String?,
        message: String?,
        icon: ImageAssetName?,
        iconColor: VColor = ThemeColorText.coloronsurface,
        action: NoDataAction? = nil
    ) {
        self.title = title
        self.message = message
        if let iconName = icon {
            self.icon = UIImage.named(iconName)
        } else {
            self.icon = nil
        }
        self.iconColor = iconColor
        self.action = action
        super.init(style: .default, reuseIdentifier: nil)
        setup()
    }
    required init?(coder: NSCoder) { return nil }

    private func setup() {
        backgroundColor = ThemeColorFill.surface.color
        selectionStyle = .none

        constrain()
    }

    private func constrain() {
        iconView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(10)
            $0.centerX.equalTo(titleLabel)
            $0.width.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(10)
            $0.left.equalTo(contentView).offset(15)
            $0.right.equalTo(contentView).offset(-15)
        }
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.right.equalTo(titleLabel)
            if action == nil {
                $0.bottom.equalTo(contentView).offset(-10)
            }
        }
        if action != nil {
            actionButton.snp.makeConstraints {
                $0.top.equalTo(messageLabel.snp.bottom).offset(10)
                $0.left.right.equalTo(titleLabel)
                $0.bottom.equalTo(contentView).offset(-10)
            }
        }
    }

    // MARK: Overrides
    private let title: String?
    private let message: String?
    private let icon: UIImage?
    private let iconColor: VColor
    private let action: NoDataAction?

    @objc private func buttonTapped() {
        action?.action()
    }

    // MARK: Lazy Loads
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = iconColor.color
        contentView.addSubview(imageView)
        return imageView
    }()
    private lazy var titleLabel: VryLabel = {
        let label = VryLabel(title, type: .headline1, textColor: .greyv1, align: .center, numLines: 0)
        contentView.addSubview(label)
        return label
    }()
    private lazy var messageLabel: VryLabel = {
        let label = VryLabel(message, type: .body1, textColor: .greyv1, align: .center, numLines: 0)
        contentView.addSubview(label)
        return label
    }()
    private lazy var actionButton: VButton = {
        let button = VButton(action?.title)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        contentView.addSubview(button)
        return button
    }()
}

