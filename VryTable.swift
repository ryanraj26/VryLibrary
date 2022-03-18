//
//  VryTable.swift
//  VryLibrary
//
//  Created by Ryan Raj on 3/18/22.
//

import UIKit
import SnapKit
import SkeletonView

class VTableView: UITableView {
    // MARK: Public API
    public func showTable() {
        currentVisible?.isHidden = false
        currentVisible?.crossfade(with: self)
        currentVisible = self
    }

    public func showSkeletonCells(animate: Bool = true) {
        currentVisible?.isHidden = false
        currentVisible?.crossfade(with: skeletonContainer, duration: animate ? 0.2 : 0)
        VSkeleton.showFor(skeletonContainer)
        currentVisible = skeletonContainer
    }

    public func showNoData(title: String,
                           message: String? = nil,
                           icon: UIImage? = nil,
                           iconColor: UIColor = ThemeColorText.greyv1.color,
                           action: NoDataAction? = nil) {
        noData.icon = icon
        noData.titleText = title
        noData.messageText = message
        noData.action = action
        noData.iconColor = iconColor

        currentVisible?.isHidden = false
        currentVisible?.crossfade(with: noData)
        currentVisible = noData
    }

    public func showError(title: String, message: String?, action: NoDataAction? = nil) {
        noData.icon = UIImage.named(.info)
        noData.titleText = title
        noData.iconColor = ThemeColorText.red.color
        if let message = message { noData.messageText = message }
        noData.action = action

        currentVisible?.isHidden = false
        currentVisible?.crossfade(with: noData)
        currentVisible = noData
    }

    // MARK: Inits
    init(skeletonCell: SkeletonCell.Type? = nil,
         numSkeletonCells: Int = 3,
         skeletonCellHeight: Double = 100,
         style: UITableView.Style = .plain) {

        self.skeletonCellType = skeletonCell
        self.numSkeletonCells = numSkeletonCells
        self.skeletonCellHeight = skeletonCellHeight

        super.init(frame: .zero, style: style)

        currentVisible = self

        separatorStyle = .none
        backgroundColor = .clear

        noData.isHidden = true
        noData.backgroundColor = .clear
        skeletonContainer.isHidden = true

        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false

        setupSkeletonCells()
    }
    required init?(coder: NSCoder) { return nil }

    // MARK: Overrides
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if let superview = superview {
            superview.addSubview(noData)
            noData.snp.makeConstraints {
                $0.top.left.right.equalTo(self)
                $0.bottom.equalTo(superview)
            }

            if skeletonCellType != nil {
                superview.addSubview(skeletonContainer)
                skeletonContainer.snp.makeConstraints {
                    $0.top.left.right.equalTo(self)
                    $0.bottom.equalTo(superview)
                }
            }
        }
    }

    // MARK: Private members
    private let noData = NoDataView()

    private let skeletonCellType: SkeletonCell.Type?
    private let numSkeletonCells: Int
    private let skeletonCellHeight: Double

    private weak var currentVisible: UIView?

    private func setupSkeletonCells() {
        if let cellType = skeletonCellType {
            var previousCell: SkeletonCell?
            for _ in 0 ..< numSkeletonCells {
                let cell = cellType.init()
                skeletonContainer.addSubview(cell)

                if let prevCell = previousCell {
                    cell.snp.makeConstraints {
                        $0.left.right.equalTo(skeletonContainer)
                        $0.top.equalTo(prevCell.snp.bottom)
                        $0.height.equalTo(skeletonCellHeight)
                    }
                    previousCell = cell
                } else {
                    previousCell = cell
                    cell.snp.makeConstraints {
                        $0.left.right.top.equalTo(skeletonContainer)
                        $0.height.equalTo(skeletonCellHeight)
                    }
                }
            }
        }
    }

    // MARK: Lazy loads
    private lazy var skeletonContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        return container
    }()

}

class SkeletonCell: UIView {
    required init() {
        super.init(frame: .zero)
        isSkeletonable = true
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) { return nil }
}
