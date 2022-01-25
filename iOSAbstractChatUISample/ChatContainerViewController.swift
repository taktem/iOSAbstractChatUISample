//
//  ChatContainerViewController.swift
//  iOSAbstractChatUISample
//
//  Created by Taku Nishimura on 2022/01/25.
//

import UIKit
import AbstractChat

final class ChatContainerViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let chatViewController = AbstractChatViewController()
        addChild(chatViewController)
        containerView.addSubview(chatViewController.view)
        chatViewController.view.snap(to: containerView)
        chatViewController.didMove(toParent: self)
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
