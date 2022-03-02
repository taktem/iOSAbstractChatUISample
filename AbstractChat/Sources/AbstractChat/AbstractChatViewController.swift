//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit
import UIUtility
import Combine

public final class AbstractChatViewController: UIViewController {

    @IBOutlet private weak var chatCollectionView: UICollectionView!
    @IBOutlet private weak var inputStackView: UIStackView!

    private var anyCancellable = Set<AnyCancellable>()
    private let keyboardObserver = KeyboardObserver()

    private let configuration: AbstractChatConfiguration
    private let registerer: ((UICollectionView) -> Void)

    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<AbstractChatSection, AbstractChatItem>! = nil

    public init<T: XibLinkedClassProtocol>(
        configuration: AbstractChatConfiguration,
        xibLinkedClasses: [T.Type]
    ) where T: UICollectionViewCell {
        self.configuration = configuration
        registerer = { target in
            xibLinkedClasses.forEach {
                target.register(xibLinkedClass: $0, bundle: Bundle.module)
            }
        }
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

    private func setupCollectionView() {
        registerer(chatCollectionView)

        chatCollectionView.delegate = self
        chatCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout { [weak self] (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let strongSelf = self else { return nil }
            let section = strongSelf.diffableDataSource.snapshot().sectionIdentifiers[section]
            return section.data.layout
        }
        chatCollectionView.transform = CGAffineTransform(scaleX: 1, y: -1)

        diffableDataSource = UICollectionViewDiffableDataSource(
            collectionView: chatCollectionView) { [weak self] _collectionView, indexPath, appliance in
                guard let strongSelf = self else { return UICollectionViewCell() }
                let section = strongSelf.diffableDataSource.snapshot().sectionIdentifiers[indexPath.section]
                let item = strongSelf.diffableDataSource.snapshot().itemIdentifiers(inSection: section)[indexPath.item]

                let cell = item.dataSource.dequeue(target: _collectionView, indexPath: indexPath)
                cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
                return cell
        }
    }

    public func configureInputComponents(
        mainInput: AbstractChatMainInputComponent,
        optionalInputs: [AbstractChatOptionalInputComponent]
    ) {
        inputStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        inputStackView.addArrangedSubview(mainInput)
        // TODO: - optionalInputs
    }

    public func configure(messages: [AbstractChatSection]) {
        var snapshot = NSDiffableDataSourceSnapshot<AbstractChatSection, AbstractChatItem>()
        messages.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems($0.data.items, toSection: $0)
        }
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension AbstractChatViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}
