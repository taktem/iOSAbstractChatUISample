//
//  Created by taktem on 2022/01/25.
//  Copyright (c) 2022 taktem. All rights reserved.
//

import Foundation

struct ChatLayoutCalculator {
    static func differenceContentOffsetFromBottomEdge(
        containerHeight: Double,
        contentHeight: Double,
        contentOffetY: Double
    ) -> Double {
        guard containerHeight < contentHeight else {
            return containerHeight
        }

        return contentHeight - contentOffetY
    }
    static func contentOffsetWithdifferenceFromBottomEdge(
        containerHeight: Double,
        contentHeight: Double,
        differenceFromBottomEdge: Double
    ) -> Double {
        guard containerHeight < contentHeight else {
            return 0
        }

        return contentHeight - differenceFromBottomEdge
    }
}
