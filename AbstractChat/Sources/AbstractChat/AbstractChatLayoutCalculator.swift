//
//  AbstractChatLayoutCalculator.swift
//  
//
//  Created by taktem on 2022/03/07.
//

import Foundation

struct AbstractChatLayoutCalculator {
    static func distanceFromBottomEdge(
        containerHeight: Double,
        contentHeight: Double,
        contentOffetY: Double
    ) -> Double {
        if containerHeight >= contentHeight {
            return containerHeight
        } else {
            return contentHeight - contentOffetY
        }
    }
}
