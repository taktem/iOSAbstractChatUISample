//
//  Created by taktem on 2022/04/14.
//  Copyright © 2022 taktem All rights reserved.
//

import UIKit

// TODO: - レイアウト仮組みしているのでメニューUIを確定させること
final class ChatItemInteractionMenuContainerView: UIView {
    final class ButtonView: UIView {
        private let onTapHandler: (() -> Void)
        
        init(name: String, onTap: @escaping () -> Void) {
            onTapHandler = onTap
            super.init(frame: .zero)
            
            backgroundColor = UIColor.green

            let button = UIButton(frame: .zero)
            button.setTitle(name, for: .normal)
            button.addTarget(self, action: #selector(Self.onTap), for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 80).isActive = true
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            
            addSubview(button)
            button.snap(to: self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc func onTap() {
            onTapHandler()
        }
    }

    struct Item {
        let name: String
        let executer: (() -> Void)
    }
    
    init(items: [Item]) {
        super.init(frame: .zero)
        
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        addSubview(stackView)
        
        stackView.snap(to: self)
        
        items.forEach {
            stackView.addArrangedSubview(ButtonView(name: $0.name, onTap: $0.executer))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
