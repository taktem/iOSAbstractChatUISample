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

    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil

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
        appendMock()
    }

    private func setupCollectionView() {
        registerer(chatCollectionView)

        chatCollectionView.delegate = self
        chatCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(200.0)
            ))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(200.0)
                ),
                subitems: [item]
            )
            return NSCollectionLayoutSection(group: group)
        }
        chatCollectionView.transform = CGAffineTransform(scaleX: 1, y: -1)

        diffableDataSource = UICollectionViewDiffableDataSource(
            collectionView: chatCollectionView) { [weak self] _collectionView,
            indexPath, appliance in
                guard let strongSelf = self else { return UICollectionViewCell() }
                let cell = strongSelf.chatCollectionView.dequeue(xibLinkedClass: AbstractChatSimpleMessageCell.self, for: indexPath, configure: { _ in })
                cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
                return cell
        }
    }

    func appendMock() {
        var snapshot = diffableDataSource.snapshot()
        Array(0..<20).forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems([$0], toSection: $0)
        }
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension AbstractChatViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}
