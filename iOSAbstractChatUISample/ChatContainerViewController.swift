//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit
import UIUtility
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

        chatViewController.configureInputComponents(
            mainInput: AbstractChatMainInputComponentText(didSubmitText: { [weak self] in
                self?.addNewMessage(text: $0)
            })
        )
    }

    private func addNewMessage(text: String) {
        let item = AbstractChatSimpleMessageItemDataSource(
            identifier: .init(value: UUID().uuidString),
            item: AbstractChatSimpleMessageCell.Item(message: text)
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

    @IBAction private func didTapCloseButton() {
        dependency.closeAction()
    }

    @IBAction private func didTapAddNewButton() {
        addNewMessage(text: "新しいメッセージ")
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
