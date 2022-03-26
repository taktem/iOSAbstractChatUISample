//
//  Created by taktem on 2022/03/22.
//  Copyright © 2022 taktem All rights reserved.
//

import UIKit

final class ChatOptionalInputComponentDummyViewController: UIViewController {

    private let didSelectImage: ((UIImage) -> Void)

    public init(
        didSelectImage: @escaping ((UIImage) -> Void)
    ) {
        self.didSelectImage = didSelectImage
        super.init(nibName: nil, bundle: Bundle.module)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction private func didTapSampleButton() {
        didSelectImage(UIImage(systemName: "photo")!)
    }
}
