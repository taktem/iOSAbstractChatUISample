//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit

public struct AbstractChatConfiguration {
    public init() {}
}

public struct AbstractChatSectionIdentifier: Hashable {
    public let value: String
    public init(value: String) {
        self.value = value
    }
}

public protocol AbstractChatSectionData {
    var identifier: AbstractChatSectionIdentifier { get }
    var layout: NSCollectionLayoutSection { get }
    var items: [AbstractChatItem] { get }
}

public struct AbstractChatSection: Hashable {
    public let data: AbstractChatSectionData

    public init(data: AbstractChatSectionData) {
        self.data = data
    }

    public static func == (lhs: AbstractChatSection, rhs: AbstractChatSection) -> Bool {
        lhs.data.identifier.hashValue == rhs.data.identifier.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(data.identifier)
    }
}

public struct AbstractChatItemIdentifier: Hashable {
    public let value: String
    public init(value: String) {
        self.value = value
    }
}

public protocol AbstractChatItemDataSource {
    var identifier: AbstractChatItemIdentifier { get }
    func dequeue(target: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

public struct AbstractChatItem: Hashable {
    public let dataSource: AbstractChatItemDataSource

    public static func == (lhs: AbstractChatItem, rhs: AbstractChatItem) -> Bool {
        lhs.dataSource.identifier.hashValue == rhs.dataSource.identifier.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(dataSource.identifier)
    }
}

public protocol AbstractChatMainInputComponent: UIView {
    
}

public struct AbstractChatOptionalInputDataSource {
    enum Icon {
        case image(UIImage)
    }
    let icon: Icon
    let component: AbstractChatOptionalInputComponent
}

public protocol AbstractChatOptionalInputComponent: UIView {

}
