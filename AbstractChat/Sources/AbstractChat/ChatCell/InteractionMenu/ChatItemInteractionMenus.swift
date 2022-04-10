//
//  Created by taktem on 2022/04/11.
//  Copyright © 2022 taktem All rights reserved.
//

import Foundation

public struct ChatItemInteractionMenuDelete: ChatItemInteractionMenuItem {

    public var name = "削除"

    private let deleteExecuter: () -> Void

    public init(deleteExecuter: @escaping () -> Void) {
        self.deleteExecuter = deleteExecuter
    }

    public func execute() {
        deleteExecuter()
    }
}

public struct ChatItemInteractionMenuCopyText: ChatItemInteractionMenuItem {
    public var name = "コピー"

    private let text: String
    private let clipBoardExecuter: (String) -> Void

    public init(
        text: String,
        clipBoardExecuter: @escaping (String) -> Void
    ) {
        self.text = text
        self.clipBoardExecuter = clipBoardExecuter
    }

    public func execute() {
        clipBoardExecuter(text)
    }
}
