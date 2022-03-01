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

    private let chatViewController = AbstractChatViewController(
        configuration: AbstractChatConfiguration(),
        xibLinkedClasses: [
            AbstractChatSimpleMessageCell.self
        ])

    private let dependency: Depndency
    private var messeges = [AbstractChatSection]()

    init(dependency: Depndency) {
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(chatViewController)
        containerView.addSubview(chatViewController.view)
        chatViewController.view.snap(to: containerView)
        chatViewController.didMove(toParent: self)
    }

    @IBAction private func didTapCloseButton() {
        dependency.closeAction()
    }

    @IBAction private func didTapAddNewButton() {
        let item = AbstractChatSimpleMessageItemDataSource(
            identifier: .init(value: UUID().uuidString),
            item: AbstractChatSimpleMessageCell.Item(message: "新しいメッセージ")
        )
        let data = AbstractChatSection(data: AbstractChatSimpleMessageSectionData(
            identifier: .init(value: UUID().uuidString),
            item: item
        ))

        if messeges.isEmpty {
            messeges = [data]
        } else {
            messeges.insert(data, at: 0)
        }
        chatViewController.configure(messages: messeges)
    }

    @IBAction private func didTapAddPrevButton() {
        let items = Array(0..<10).map {
            AbstractChatSimpleMessageItemDataSource(
                identifier: .init(value: UUID().uuidString),
                item: AbstractChatSimpleMessageCell.Item(message: "古いメッセージ: \($0)")
            )
        }
        let data = items.map {
            AbstractChatSection(data: AbstractChatSimpleMessageSectionData(
                identifier: .init(value: UUID().uuidString),
                item: $0
            ))
        }
        messeges.append(contentsOf: data)
        chatViewController.configure(messages: messeges)
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
