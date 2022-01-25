//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit

public protocol XibLinkedClassProtocol: AnyObject {}

private extension XibLinkedClassProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

public extension UICollectionView {
    func register<T: XibLinkedClassProtocol>(xibLinkedClass: T.Type, bundle: Bundle) where T: UICollectionViewCell {
        let className = String(describing: T.self)
        register(UINib(nibName: className, bundle: bundle), forCellWithReuseIdentifier: className)
    }
    func dequeue<T: XibLinkedClassProtocol>(xibLinkedClass: T.Type, for indexPath: IndexPath, configure: (T) -> Void) -> T where T: UICollectionViewCell {
        let className = String(describing: T.self)
        let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as! T
        configure(cell)
        return cell
    }
}
