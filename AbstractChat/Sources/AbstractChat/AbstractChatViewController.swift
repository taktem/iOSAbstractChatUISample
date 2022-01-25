//
//  AbstractChatViewController.swift
//  
//
//  Created by Taku Nishimura on 2022/01/24.
//

import UIKit

public final class AbstractChatViewController: UIViewController {

    public init() {
        super.init(nibName: nil, bundle: Bundle.module)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
