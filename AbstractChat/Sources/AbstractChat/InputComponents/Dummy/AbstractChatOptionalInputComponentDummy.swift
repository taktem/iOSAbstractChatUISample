//
//  Created by taktem on 2022/03/22.
//  Copyright © 2022 taktem All rights reserved.
//

import UIKit

public final class AbstractChatOptionalInputDataSourceDummy: AbstractChatOptionalInputDataSource {
    public typealias Response = UIImage

    public let icon = UIImage(systemName: "photo")!
    public var executer: (() -> Void)

    public init(
        targetBaseViewController: UIViewController,
        didSelectImage: @escaping (UIImage) -> Void
    ) {
        executer = { [weak targetBaseViewController] in
            let component = AbstractChatOptionalInputComponentDummyViewController(didSelectImage: {
                didSelectImage($0)
                targetBaseViewController?.dismiss(animated: true)
            })
            targetBaseViewController?.present(component, animated: true)
        }
    }
}
