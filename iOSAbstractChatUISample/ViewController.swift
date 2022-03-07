//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBAction private func didTapPresentButton() {
        let controller = ChatContainerViewController(dependency: .init(
            closeAction: { [weak self] in
                self?.dismiss(animated: true)
            }
        ))
        if #available(iOS 15.0, *) {
            if let sheet = controller.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersScrollingExpandsWhenScrolledToEdge = true
                sheet.prefersEdgeAttachedInCompactHeight = false
                sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            }
            present(controller, animated: true, completion: nil)
        } else {
            present(controller, animated: true, completion: nil)
        }
    }
}
