//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit
import UIUtility

public struct ChatSimpleMessageSectionData: ChatSectionData {
    public let layout: NSCollectionLayoutSection = {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44.0)
        ))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(44.0)
            ),
            subitems: [item]
        )
        return NSCollectionLayoutSection(group: group)
    }()

    public let identifier: ChatSectionIdentifier
    public let items: [ChatItem]

    public init(
        identifier: ChatSectionIdentifier,
        item: ChatSimpleMessageItemDataSource
    ) {
        self.identifier = identifier
        self.items = [ChatItem.init(dataSource: item)]
    }
}

public struct ChatSimpleMessageItemDataSource: ChatItemDataSource {

    public let identifier: ChatItemIdentifier

    private let item: ChatSimpleMessageCell.Item

    public init(
        identifier: ChatItemIdentifier,
        item: ChatSimpleMessageCell.Item
    ) {
        self.identifier = identifier
        self.item = item
    }

    public func dequeue(target: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        target.dequeue(
            xibLinkedClass: ChatSimpleMessageCell.self,
            for: indexPath) {
                $0.configure(item: item)
            }
    }

    public func isSameContents(to: ChatItemDataSource) -> Bool {
        guard let target = to as? ChatSimpleMessageItemDataSource else { return false }
        return identifier == target.identifier &&
        item == item
    }
}

public final class ChatSimpleMessageCell: UICollectionViewCell {
    public struct Item: Equatable {
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

extension ChatSimpleMessageCell: XibLinkedClassProtocol {}
