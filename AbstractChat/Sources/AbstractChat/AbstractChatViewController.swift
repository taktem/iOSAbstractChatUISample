//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit
import UIUtility

public final class AbstractChatViewController: UIViewController {

    @IBOutlet private weak var chatCollectionView: UICollectionView!

    private let configuration: AbstractChatConfiguration
    private let registerer: ((UICollectionView) -> Void)

    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<AbstractChatSection, AbstractChatItem>! = nil
    private var sections: [AbstractChatSection] = []

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

        setupCollectionView()
    }

    private func setupCollectionView() {
        registerer(chatCollectionView)

        chatCollectionView.delegate = self
        chatCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout { [weak self] (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let strongSelf = self else { return nil }
            let section = strongSelf.sections[section]
            return section.data.layout
        }
        chatCollectionView.transform = CGAffineTransform(scaleX: 1, y: -1)

        diffableDataSource = UICollectionViewDiffableDataSource(
            collectionView: chatCollectionView) { [weak self] _collectionView, indexPath, appliance in
                guard let strongSelf = self else { return UICollectionViewCell() }
                let item = strongSelf.sections[indexPath.section].data.items[indexPath.item]

                let cell = item.dataSource.dequeue(target: _collectionView, indexPath: indexPath)
                cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
                return cell
        }
    }

    public func append(previewsMessages: [AbstractChatSection]) {
        var snapshot = diffableDataSource.snapshot()
        previewsMessages.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems($0.data.items, toSection: $0)
        }
        sections.append(contentsOf: previewsMessages)
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }

    public func append(newMessage: AbstractChatSection) {
        var snapshot = diffableDataSource.snapshot()
        if let beforeSection = sections.first {
            snapshot.insertSections([newMessage], beforeSection: beforeSection)
        } else {
            snapshot.appendSections([newMessage])
        }
        snapshot.appendItems(newMessage.data.items, toSection: newMessage)
        sections.insert(newMessage, at: 0)
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension AbstractChatViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}
