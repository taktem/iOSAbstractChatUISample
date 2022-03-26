//
//  Created by taktem on 2022/03/08.
//  Copyright © 2022 taktem All rights reserved.
//

import XCTest
@testable import Chat

final class ChatLayoutCalculatorTests: XCTestCase {
    func test下端とのcontentOffsetYを測る() {
        func test(
            containerHeight: Double,
            contentHeight: Double,
            contentOffetY: Double,
            expect: Double,
            line: UInt = #line
        ) {
            XCTAssertEqual(
                ChatLayoutCalculator.differenceContentOffsetFromBottomEdge(
                    containerHeight: containerHeight,
                    contentHeight: contentHeight,
                    contentOffetY: contentOffetY
                ),
                expect,
                line: line
            )
        }

        // スクロール位置が下端まで到達している時は、結果は常にコンテナの高さとおなじになる
        test(containerHeight: 600.0, contentHeight: 0, contentOffetY: 0, expect: 600)
        test(containerHeight: 600.0, contentHeight: 600, contentOffetY: 0, expect: 600)
        test(containerHeight: 600.0, contentHeight: 601, contentOffetY: 1, expect: 600)
        test(containerHeight: 600.0, contentHeight: 1000, contentOffetY: 400, expect: 600)

        // contentOffetYが0の場合は、コンテナの高さをコンテンツの高さが超えた時が境界となる
        test(containerHeight: 600.0, contentHeight: 601, contentOffetY: 0, expect: 601)
    }

    func test下端と距離を元にcontentOffsetの値を得る() {
        func test(
            containerHeight: Double,
            contentHeight: Double,
            difference: Double,
            expect: Double,
            line: UInt = #line
        ) {
            XCTAssertEqual(
                ChatLayoutCalculator.contentOffsetWithdifferenceFromBottomEdge(
                    containerHeight: containerHeight,
                    contentHeight: contentHeight,
                    differenceFromBottomEdge: difference),
                expect,
                line: line
            )
        }

        // コンテンツの高さとdifferenceの合算がコンテナの高さを超えない限り期待値は常に0
        test(containerHeight: 600.0, contentHeight: 0, difference: 200, expect: 0)
        test(containerHeight: 600.0, contentHeight: 600, difference: 0, expect: 0)
        test(containerHeight: 600.0, contentHeight: 0, difference: 600, expect: 0)
    }
}
