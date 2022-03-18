//
//  VryLabel.swift
//  VryLibrary
//
//  Created by Ryan Raj on 3/18/22.
//

import UIKit

enum VryLabelType {
    case headline1,
         headline2,
         headline3,
         headline4,
         headline5,
         headline6,
         subtitle1,
         subtitle2,
         body1,
         body2,
         overline,
         caption,
         footnote

    var font: UIFont {
        switch self {
            case .headline1: return .vryAvenirNextDemiBold(36)!
            case .headline2: return .vryAvenirNextDemiBold(28)!
            case .headline3: return .vryAvenirNextDemiBold(22)!
            case .headline4: return .vryAvenirNextDemiBold(18)!
            case .headline5: return .vryAvenirNextDemiBold(16)!
            case .headline6: return .vryAvenirNextDemiBold(14)!
            case .subtitle1: return .vryAvenirNextMedium(16)!
            case .subtitle2: return .vryAvenirNextDemiBold(12)!
            case .body1: return .vryAvenirNextRegular(16)!
            case .body2: return .vryAvenirNextRegular(14)!
            case .overline: return .vryAvenirNextRegular(12)!
            case .caption: return .vryAvenirNextRegular(12)!
            case .footnote: return .vryAvenirNextItalic(12)!
        }
    }
}

class VryLabel: UILabel {
    // MARK: Public API

    var isTruncated: Bool {
        guard let text = text, let font = font, bounds.size.height > 0 else {
            return false
        }

        let labelTextSize = (text as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        ).size

        return labelTextSize.height > bounds.size.height
    }

    // MARK: Inits
    init(_ text: String? = nil,
         type: VryLabelType,
         textColor: ThemeColorText = .greyv1,
         align: NSTextAlignment = .left,
         numLines: Int = 1) {
        self.labelType = type
        super.init(frame: .zero)

        self.text = text
        self.font = type.font
        self.textColor = textColor.color
        self.textAlignment = align
        self.numberOfLines = numLines
    }
    required init?(coder: NSCoder) { return nil }

    // MARK: Overrides
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if isUserInteractionEnabled {
            let hitFrame = bounds.insetBy(dx: -5, dy: -15)
            return hitFrame.contains(point)
        } else {
            return super.point(inside: point, with: event)
        }
    }

    override var text: String? {
        set {
            if labelType == .overline {
                super.attributedText = NSAttributedString(
                    string: newValue ?? "",
                    attributes: [.kern: 1]
                )
            } else {
                super.text = newValue
            }
        }
        get { super.text }
    }

    // MARK: Private members
    let labelType: VryLabelType
}
