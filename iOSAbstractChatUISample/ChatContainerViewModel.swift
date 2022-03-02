//
//  ChatContainerViewModel.swift
//  iOSAbstractChatUISample
//
//  Created by Taku Nishimura on 2022/03/02.
//

import Foundation
import Combine
import AbstractChat

final class ChatContainerViewModel: ObservableObject {
    enum Event {
        case requestedClose
    }

    let event = PassthroughSubject<Event, Never>()
    let messeges = CurrentValueSubject<[AbstractChatSection], Never>([])

    func didSubmit(text: String) {
        addNewMessage(text: text)
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

        if messeges.value.isEmpty {
            messeges.send([data])
        } else {
            messeges.value.insert(data, at: 0)
        }
    }

    func didTapCloseButton() {
        event.send(.requestedClose)
    }

    // Mock
    func didTapAddPrevButton() {
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
        messeges.value.append(contentsOf: data)
    }
}
