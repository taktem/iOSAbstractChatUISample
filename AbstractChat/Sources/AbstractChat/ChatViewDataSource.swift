//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit

public struct ChatConfiguration {
    public init() {}
}

// Message Components
public struct ChatSectionIdentifier: Hashable {
    public let value: String
    public init(value: String) {
        self.value = value
    }
}

public protocol ChatSectionData {
    var identifier: ChatSectionIdentifier { get }
    var layout: NSCollectionLayoutSection { get }
    var items: [ChatItem] { get }
}

public struct ChatSection: Hashable {
    public let data: ChatSectionData

    public init(data: ChatSectionData) {
        self.data = data
    }

    public static func == (lhs: ChatSection, rhs: ChatSection) -> Bool {
        lhs.data.identifier == rhs.data.identifier
        && lhs.data.items == rhs.data.items
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(data.identifier)
    }
}

public struct ChatItemIdentifier: Hashable {
    public let value: String
    public init(value: String) {
        self.value = value
    }
}

public protocol ChatItemInteractionMenuItem {
    var name: String { get }
    func execute()
}

public enum ChatItemInteractionMenus {
    case available(items: [ChatItemInteractionMenuItem])
    case notAvailable
}

public protocol ChatItemDataSource {
    var identifier: ChatItemIdentifier { get }
    var interactionMenus: ChatItemInteractionMenus { get }
    func dequeue(target: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func isSameContents(to: ChatItemDataSource) -> Bool
}

public struct ChatItem: Hashable {
    public let dataSource: ChatItemDataSource

    public static func == (lhs: ChatItem, rhs: ChatItem) -> Bool {
        lhs.dataSource.identifier == rhs.dataSource.identifier &&
        lhs.dataSource.isSameContents(to: rhs.dataSource)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(dataSource.identifier)
    }
}


// Inputs
public protocol ChatMainInputComponent: UIView {

}

public protocol ChatOptionalInputDataSource {
    var icon: UIImage { get }
    var executer: (() -> Void) { get }
}

extension ChatOptionalInputDataSource {
    func execute() {
        executer()
    }
}
