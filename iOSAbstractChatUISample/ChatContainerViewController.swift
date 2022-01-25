//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit
import AbstractChat

final class ChatContainerViewController: UIViewController {

    struct Depndency {
        let closeAction: (() -> Void)
    }

    @IBOutlet private weak var containerView: UIView!

    private let dependency: Depndency

    init(dependency: Depndency) {
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let chatViewController = AbstractChatViewController(
            configuration: AbstractChatConfiguration(),
            xibLinkedClasses: [
                AbstractChatSimpleMessageCell.self
            ])
        addChild(chatViewController)
        containerView.addSubview(chatViewController.view)
        chatViewController.view.snap(to: containerView)
        chatViewController.didMove(toParent: self)
    }

    @IBAction private func didTapCloseButton() {
        dependency.closeAction()
    }
}

private extension UIView {
    func snap(to view: UIView, edgeInsets: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: edgeInsets.top).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -edgeInsets.bottom).isActive = true

        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgeInsets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgeInsets.right).isActive = true
    }
}
