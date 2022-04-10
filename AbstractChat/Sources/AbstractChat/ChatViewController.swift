//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit
import UIUtility
import Combine

public final class ChatViewController: UIViewController {

    @IBOutlet private weak var chatCollectionView: UICollectionView!
    @IBOutlet private weak var inputStackView: UIStackView!

    private var anyCancellable = Set<AnyCancellable>()
    private let keyboardObserver = KeyboardObserver()

    private let configuration: ChatConfiguration

    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<ChatSection, ChatItem>! = nil

    public init(configuration: ChatConfiguration) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: Bundle.module)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupBinding()
        setupCollectionView()
    }

    private func setupBinding() {
        keyboardObserver.stream
            .sink { [weak self] in self?.applyAdditionalSafeAreaInsetsBottom(with: $0) }
            .store(in: &anyCancellable)
    }

    public func register<T: XibLinkedClassProtocol>(xibLinkedClasses: T.Type) where T: UICollectionViewCell {
        chatCollectionView.register(xibLinkedClass: xibLinkedClasses, bundle: Bundle.module)
    }

    private func setupCollectionView() {
        chatCollectionView.delegate = self
        chatCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout { [weak self] (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let strongSelf = self else { return nil }
            let section = strongSelf.diffableDataSource.snapshot().sectionIdentifiers[section]
            return section.data.layout
        }

        diffableDataSource = UICollectionViewDiffableDataSource(
            collectionView: chatCollectionView) { [weak self] _collectionView, indexPath, appliance in
                guard let strongSelf = self else { return UICollectionViewCell() }
                let section = strongSelf.diffableDataSource.snapshot().sectionIdentifiers[indexPath.section]
                let item = strongSelf.diffableDataSource.snapshot().itemIdentifiers(inSection: section)[indexPath.item]

                let cell = item.dataSource.dequeue(target: _collectionView, indexPath: indexPath)

                let longTapGesture = UILongPressGestureRecognizer(
                    target: strongSelf,
                    action: #selector(ChatViewController.didTapCollectionViewCell(_:)))
                longTapGesture.delegate = strongSelf

                cell.addGestureRecognizer(longTapGesture)

                return cell
        }
    }

    public func configureInputComponents(
        mainInput: ChatMainInputComponent,
        optionalInputs: [ChatOptionalInputDataSource]
    ) {
        inputStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        if (!optionalInputs.isEmpty) {
            inputStackView.addArrangedSubview(ChatOptionalInputLauncherComponent(didTap: {
                // 複数のコンポーネント発火はいったん後回し
                optionalInputs.first?.execute()
            }))
        }

        inputStackView.addArrangedSubview(mainInput)
    }

    public func configure(messages: [ChatSection]) {
        let beforePosition = ChatLayoutCalculator.differenceContentOffsetFromBottomEdge(
            containerHeight: chatCollectionView.bounds.height,
            contentHeight: chatCollectionView.contentSize.height,
            contentOffetY: chatCollectionView.contentOffset.y
        )
        var snapshot = NSDiffableDataSourceSnapshot<ChatSection, ChatItem>()
        messages.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems($0.data.items, toSection: $0)
        }
        diffableDataSource.apply(snapshot, animatingDifferences: false)

        let resultPosition = ChatLayoutCalculator.contentOffsetWithdifferenceFromBottomEdge(
            containerHeight: chatCollectionView.bounds.height,
            contentHeight: chatCollectionView.contentSize.height,
            differenceFromBottomEdge: beforePosition
        )
        chatCollectionView.setContentOffset(.init(x: 0, y: resultPosition), animated: true)
    }
}

extension ChatViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}

extension ChatViewController: UIGestureRecognizerDelegate {
    @objc func didTapCollectionViewCell(_ sender: UILongPressGestureRecognizer) {
        guard let cell = sender.view as? ChatItemLongTappableCell else { return }
        switch sender.state {
        case .began:
            let rect = chatCollectionView.convert(cell.frame, to: self.view)
            cell.didLongTap(rectOnBaseView: rect)
        case .possible, .ended, .changed, .cancelled, .failed: ()
        @unknown default: ()
        }
    }
}
