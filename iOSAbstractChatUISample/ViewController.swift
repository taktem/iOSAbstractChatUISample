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
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}
