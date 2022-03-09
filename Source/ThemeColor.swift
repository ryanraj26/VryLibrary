//
//  ThemeColor.swift
//  VryLibrary
//
//  Created by Ryan Raj on 3/9/22.
//

import UIKit

//i18n ignore-all

// MARK: Special case colors
public enum DatePanel: VColor {
    case upcoming, accepted, pending, text, paylabel
    public var color: UIColor {
        switch self {
            case .upcoming: return UIColor(named: "DatePanelUpcomingBG")!
            case .accepted: return UIColor(named: "DatePanelAcceptedBG")!
            case .pending: return UIColor(named: "DatePanelPendingBG")!
            case .text: return UIColor(named: "DatePanelText")!
            case .paylabel: return UIColor(named: "PayLabelText")!
        }
    }
}

public enum ScheduleCellBody: VColor {
    case text, estpay
    public var color: UIColor {
        switch self {
            case .text: return UIColor(named: "ScheduleCellBodyText")!
            case .estpay: return UIColor(named: "EstPayText")!
        }
    }
}

public enum OpsCellBody: VColor {
    case text
    public var color: UIColor {
        switch self {
            case .text: return UIColor(named: "OpsCellBodyText")!
        }
    }
}

public enum JourneyColors: VColor {
    case requirementchiptext, requirementchipfill, pageindicator
    public var color: UIColor {
        switch self {
            case .requirementchiptext: return UIColor(named: "RequirementChipText")!
            case .requirementchipfill: return UIColor(named: "RequirementChipFill")!
            case .pageindicator: return UIColor(named: "PageIndicatorColor")!
        }
    }
}

public enum VaultColors: VColor {
    case transactioniconfill, transactioniconlabel, cardreorderBackground
    public var color: UIColor {
        switch self {
            case .transactioniconfill: return UIColor(named: "TransactionIconFill")!
            case .transactioniconlabel: return UIColor(named: "TransactionIconLabel")!
            case .cardreorderBackground: return UIColor(named: "CardReorderBG")!
        }
    }
}

public enum ChipColor: VColor {
    case selected, unselected, shadow
    public var color: UIColor {
        switch self {
            case .selected: return UIColor(named: "SelectedTitle")!
            case .unselected: return UIColor(named: "UnselectedTitle")!
            case .shadow: return UIColor(named: "ChipShadow")!
        }
    }
    var backgroundColor: UIColor {
        switch self {
            case .selected: return UIColor(named: "SelectedBackground")!
            case .unselected: return UIColor(named: "ColorDisabled")!
            case .shadow: return UIColor(named: "ChipShadow")!
        }
    }
}

public enum SidebarColor: VColor {
    case selected, unselected
    public var color: UIColor {
        switch self {
            case .selected: return UIColor(named: "SidebarItemSelectedText")!
            case .unselected: return UIColor(named: "SidebarItemUnselectedText")!
        }
    }
    var backgroundColor: UIColor {
        switch self {
            case .selected: return UIColor(named: "SidebarItemSelectedBG")!
            case .unselected: return UIColor.clear
        }
    }
}

// MARK: Fill Colors
public enum ThemeColorFill: VColor {
    case primary, secondary, orange, purple, red, pink, yellow, lime, background, surface, primaryv2, blue, clear, colorlimev2
    public var color: UIColor {
        switch self {
            case .primary: return UIColor(named: "ColorPrimary")!
            case .secondary: return UIColor(named: "ColorSecondary")!
            case .orange: return UIColor(named: "ColorOrangeFill")!
            case .purple: return UIColor(named: "ColorPurpleFill")!
            case .red: return UIColor(named: "ColorRedFill")!
            case .pink: return UIColor(named: "ColorPinkFill")!
            case .yellow: return UIColor(named: "ColorYellowFill")!
            case .lime: return UIColor(named: "ColorLimeFill")!
            case .surface: return UIColor(named: "ColorSurface")!
            case .background: return UIColor(named: "ColorBackground")!
            case .primaryv2: return UIColor(named: "ColorPrimaryV2")!
            case .blue: return UIColor(named: "ColorBlue")!
            case .clear: return UIColor.clear
            case .colorlimev2: return UIColor(named: "ColorLimeV2")!
        }
    }
}

// MARK: Text Colors
public enum ThemeColorText: VColor {
    case primary, secondary, orange, purple, red, pink, yellow, lime, coloroncolor, coloronsurface, coloronbackground, greyv1, greyv2, colordisabled
    public var color: UIColor {
        switch self {
            case .primary: return UIColor(named: "ColorPrimaryText")!
            case .secondary: return UIColor(named: "ColorSecondaryText")!
            case .orange: return UIColor(named: "ColorOrangeText")!
            case .purple: return UIColor(named: "ColorPurpleText")!
            case .red: return UIColor(named: "ColorRedText")!
            case .pink: return UIColor(named: "ColorPinkText")!
            case .yellow: return UIColor(named: "ColorYellowText")!
            case .lime: return UIColor(named: "ColorLimeText")!
            case .coloroncolor: return UIColor(named: "ColorOnColor")!
            case .coloronsurface: return UIColor(named: "ColorOnSurface")!
            case .coloronbackground: return UIColor(named: "ColorOnBackground")!
            case .greyv1: return UIColor(named: "ColorGreyV1")!
            case .greyv2: return UIColor(named: "ColorGreyV2")!
            case .colordisabled: return UIColor(named: "ColorDisabled")!
        }
    }
}
