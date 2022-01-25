//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit
import UIUtility

public struct AbstractChatSimpleMessageCellFactory: AbstractChatCellFactory {
    private let item: AbstractChatSimpleMessageCell.Item
    public init(item: AbstractChatSimpleMessageCell.Item) {
        self.item = item
    }

    func dequeue(target: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
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
