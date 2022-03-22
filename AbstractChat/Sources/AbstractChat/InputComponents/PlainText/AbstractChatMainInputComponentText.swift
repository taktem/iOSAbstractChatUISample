//
//  AbstractChatInputCompo.swift
//  
//
//  Created by taktem on 2022/03/01.
//

import UIKit
import UIUtility

public final class AbstractChatMainInputComponentText: UIView, AbstractChatMainInputComponent {

    @IBOutlet private var textView: UITextView!
    @IBOutlet private var textViewHeightConstraint: NSLayoutConstraint!

    private let didSubmitText: ((String) -> Void)

    public init(
        didSubmitText: @escaping ((String) -> Void)
    ) {
        self.didSubmitText = didSubmitText
        super.init(frame: .zero)
        let nib = UINib(nibName: "AbstractChatMainInputComponentText", bundle: Bundle.module)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        view.snap(to: self)
        textView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction private func didTapSendButton() {
        guard let text = textView.text else { return }
        textView.text = nil
        adjustTextViewHeight()
        didSubmitText(text)

        endEditing(true)
    }

    private func adjustTextViewHeight() {
        let height = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
        textViewHeightConstraint.constant = height
    }
}

extension AbstractChatMainInputComponentText: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        adjustTextViewHeight()
    }
}
