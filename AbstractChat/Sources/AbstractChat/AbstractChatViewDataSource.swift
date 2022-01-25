//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit

public struct AbstractChatConfiguration {
    public init() {}
}

protocol AbstractChatCellFactory {
    func dequeue(target: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}
