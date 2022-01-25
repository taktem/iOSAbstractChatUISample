//
//  ViewController.swift
//  iOSAbstractChatUISample
//
//  Created by Taku Nishimura on 2022/01/24.
//

import UIKit

final class ViewController: UIViewController {

    @IBAction private func didTapPresentButton() {
        let controller = ChatContainerViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}
