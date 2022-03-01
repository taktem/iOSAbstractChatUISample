//
//  File.swift
//  
//
//  Created by Taku Nishimura on 2022/03/01.
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
}
