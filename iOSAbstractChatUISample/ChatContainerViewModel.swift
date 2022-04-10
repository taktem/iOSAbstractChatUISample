//
//  Created by taktem on 2022/03/02.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import Foundation
import Combine
import AbstractChat
import UIKit

final class ChatContainerViewModel: ObservableObject {
    enum Event {
        case requestedClose
    }

    let event = PassthroughSubject<Event, Never>()
    let messeges = CurrentValueSubject<[ChatSection], Never>([])

    func didSubmit(text: String) {
        addNewMessage(text: text)
    }

    func didSubmit(image: UIImage) {
        
    }

    private func addNewMessage(text: String) {
        let identifier = UUID().uuidString
        let item = ChatSimpleMessageItemDataSource(
            identifier: .init(value: identifier),
            item: ChatSimpleMessageCell.Item(message: text),
            interactionMenus: ChatItemInteractionMenus.available(items: [
                ChatItemInteractionMenuCopyText(
                    text: text,
                    clipBoardExecuter: {
                        print("コピー: \($0) from \(identifier)")
                        // ここでクリップボードへの保存と、保存した旨のメッセージ
                    }
                ),
                ChatItemInteractionMenuDelete(
                    deleteExecuter: {
                        print("削除: \(identifier)")
                        // ここでクリップボードへの保存と、保存した旨のメッセージ
                    })
            ])
        )
        let data = ChatSection(data: ChatSimpleMessageSectionData(
            identifier: .init(value: UUID().uuidString),
            item: item
        ))

        messeges.value.append(contentsOf: [data])
    }

    func didTapCloseButton() {
        event.send(.requestedClose)
    }

    // Mock
    func didTapAddPrevButton() {
        let items = Array(0..<10).map {
            ChatSimpleMessageItemDataSource(
                identifier: .init(value: UUID().uuidString),
                item: ChatSimpleMessageCell.Item(message: "古いメッセージ: \($0)"),
                interactionMenus: ChatItemInteractionMenus.notAvailable
            )
        }
        let data = items.map {
            ChatSection(data: ChatSimpleMessageSectionData(
                identifier: .init(value: UUID().uuidString),
                item: $0
            ))
        }
        if messeges.value.isEmpty {
            messeges.send(data)
        } else {
            messeges.value.insert(contentsOf: data, at: 0)
        }
    }
}
