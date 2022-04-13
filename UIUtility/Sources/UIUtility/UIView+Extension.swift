//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import UIKit

public extension UIView {
    func snap(to view: UIView, edgeInsets: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: edgeInsets.top).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -edgeInsets.bottom).isActive = true

        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgeInsets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgeInsets.right).isActive = true
    }
    
    func snapOnTop(of view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func snapOnBottom(of view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
