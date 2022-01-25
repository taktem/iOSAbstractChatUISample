//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit
import UIUtility

public struct AbstractChatSimpleMessageSectionData: AbstractChatSectionData {
    public let layout: NSCollectionLayoutSection = {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200.0)
        ))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(200.0)
            ),
            subitems: [item]
        )
        return NSCollectionLayoutSection(group: group)
    }()

    public let identifier: AbstractChatSectionIdentifier
    public let items: [AbstractChatItem]

    public init(
        identifier: AbstractChatSectionIdentifier,
        item: AbstractChatSimpleMessageItemDataSource
    ) {
        self.identifier = identifier
        self.items = [AbstractChatItem.init(dataSource: item)]
    }
}

public struct AbstractChatSimpleMessageItemDataSource: AbstractChatItemDataSource {
    public let identifier: AbstractChatItemIdentifier

    private let item: AbstractChatSimpleMessageCell.Item

    public init(
        identifier: AbstractChatItemIdentifier,
        item: AbstractChatSimpleMessageCell.Item
    ) {
        self.identifier = identifier
        self.item = item
    }

    public func dequeue(target: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        target.dequeue(
            xibLinkedClass: AbstractChatSimpleMessageCell.self,
            for: indexPath) {
                $0.configure(item: item)
            }
    }
}

public final class AbstractChatSimpleMessageCell: UICollectionViewCell {
    public struct Item {
        public init(message: String) {
            self.message = message
        }

        let message: String
    }

    @IBOutlet public private(set) weak var messageLabel: UILabel!

    public func configure(item: Item) {
        messageLabel.text = item.message
    }
}

extension AbstractChatSimpleMessageCell: XibLinkedClassProtocol {}
