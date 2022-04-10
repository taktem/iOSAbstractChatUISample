//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit
import UIUtility
import AbstractChat
import Combine

final class ChatContainerViewController: UIViewController {

    struct Depndency {
        let closeAction: (() -> Void)
    }

    @IBOutlet private weak var containerView: UIView!

    private let chatViewController = ChatViewController(configuration: ChatConfiguration())

    private let dependency: Depndency
    private var cancellables = Set<AnyCancellable>()
    private let viewModel = ChatContainerViewModel()
    private var messeges = [ChatSection]()

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

        setupBinding()
        setupChatView()
    }

    private func setupChatView() {
        chatViewController.register(xibLinkedClasses: ChatSimpleMessageCell.self)
        chatViewController.configureInputComponents(
            mainInput: ChatMainInputComponentText(didSubmitText: { [weak self] in
                self?.viewModel.didSubmit(text: $0)
            }),
            optionalInputs: [
                ChatOptionalInputDataSourceDummy(
                    targetBaseViewController: self,
                    didSelectImage: { [weak self] in
                        self?.viewModel.didSubmit(image: $0)
                    })
            ]
        )
    }

    private func setupBinding() {
        viewModel.event
            .sink(receiveValue: { [weak self] in
                switch $0 {
                case .requestedClose:
                    self?.dependency.closeAction()
                }
            })
            .store(in: &cancellables)

        viewModel.messeges
            .sink(receiveValue: { [weak self] in
                self?.chatViewController.configure(messages: $0)
            })
            .store(in: &cancellables)
    }

    @IBAction private func didTapCloseButton() {
        viewModel.didTapCloseButton()
    }

    // Mock
    @IBAction private func didTapAddNewButton() {
        viewModel.didSubmit(text: "新しいメッセージ")
    }

    @IBAction private func didTapAddPrevButton() {
        viewModel.didTapAddPrevButton()
    }
}
