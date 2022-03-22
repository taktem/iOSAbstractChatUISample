//
//  Created by taktem on 2022/03/22.
//  Copyright © 2022 taktem All rights reserved.
//

import UIKit

final class AbstractChatOptionalInputLauncherComponent: UIView {
    private let didTap: (() -> Void)

    public init(
        didTap: @escaping (() -> Void)
    ) {
        self.didTap = didTap
        super.init(frame: .zero)
        let nib = UINib(nibName: "AbstractChatOptionalInputLauncherComponent", bundle: Bundle.module)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        view.snap(to: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction private func didTapButton() {
        didTap()
    }
}
