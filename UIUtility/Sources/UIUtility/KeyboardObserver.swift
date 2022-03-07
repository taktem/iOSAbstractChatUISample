//
//  File.swift
//  
//
//  Created by taktem on 2022/03/01.
//

import UIKit
import Combine

public struct KeyboardInfo {
    public let frame: CGRect?
    public let duration: TimeInterval

    public static let initial = KeyboardInfo(frame: nil, duration: 0)
}

public extension UIViewController {
    func applyAdditionalSafeAreaInsetsBottom(with keyboardInfo: KeyboardInfo, completion: ((Bool) -> Void)? = nil) {
        guard let frame = keyboardInfo.frame else {
            additionalSafeAreaInsets.bottom = 0
            return
        }
        let keyboardFrameInView = view.convert(frame, from: nil)
        let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame.insetBy(
            dx: 0,
            dy: -additionalSafeAreaInsets.bottom
        )
        let intersection = safeAreaFrame.intersection(keyboardFrameInView)

        additionalSafeAreaInsets.bottom = intersection.height
        UIView.animate(
            withDuration: keyboardInfo.duration,
            animations: { self.view.layoutIfNeeded() },
            completion: completion
        )
    }
}

public struct KeyboardObserver {

    public init() {}

    public let stream: AnyPublisher<KeyboardInfo, Never> = Publishers.Merge3(
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification, object: nil)
            .map { (isVisible: true, notification: $0) },
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification, object: nil)
            .map { (isVisible: true, notification: $0) },
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification, object: nil)
            .map { (isVisible: false, notification: $0) }
    )
        .map(KeyboardObserver.calculate)
        .eraseToAnyPublisher()

    private static func calculate(isVisible: Bool, notification: Notification) -> KeyboardInfo {
        if !isVisible {
            return KeyboardInfo(
                frame: nil,
                duration: notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
            )
        } else if
            let userInfo = notification.userInfo,
            let frameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        {
            return KeyboardInfo(
                frame: frameValue.cgRectValue,
                duration: userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
            )
        } else {
            return KeyboardInfo(
                frame: nil,
                duration: notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
            )
        }
    }
}

