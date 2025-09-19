import XCTest
@testable import FIBONACCI_APPTests

fileprivate extension FibonacciServiceTests {
    @available(*, deprecated, message: "Not actually deprecated. Marked as deprecated to allow inclusion of deprecated tests (which test deprecated functionality) without warnings")
    static nonisolated(unsafe) let __allTests__FibonacciServiceTests = [
        ("testFibonacciAtBasicCases", testFibonacciAtBasicCases),
        ("testFibonacciAtLargePosition", testFibonacciAtLargePosition),
        ("testFibonacciAtNegativePosition", testFibonacciAtNegativePosition),
        ("testFibonacciAtTooLargePosition", testFibonacciAtTooLargePosition),
        ("testFibonacciSequenceBasic", testFibonacciSequenceBasic),
        ("testFibonacciSequenceEdgeCases", testFibonacciSequenceEdgeCases),
        ("testFibonacciSequenceNegativeCount", testFibonacciSequenceNegativeCount),
        ("testFibonacciSequenceTooLargeCount", testFibonacciSequenceTooLargeCount),
        ("testFibonacciSequenceUpToBasic", testFibonacciSequenceUpToBasic),
        ("testFibonacciSequenceUpToEdgeCases", testFibonacciSequenceUpToEdgeCases),
        ("testGoldenRatioApproximation", testGoldenRatioApproximation),
        ("testGoldenRatioApproximationEdgeCases", testGoldenRatioApproximationEdgeCases),
        ("testIsFibonacciInvalid", testIsFibonacciInvalid),
        ("testIsFibonacciNegative", testIsFibonacciNegative),
        ("testIsFibonacciValid", testIsFibonacciValid),
        ("testPerformanceFibonacciAtPosition", testPerformanceFibonacciAtPosition),
        ("testPerformanceFibonacciSequence", testPerformanceFibonacciSequence),
        ("testPerformanceGoldenRatio", testPerformanceGoldenRatio)
    ]
}
@available(*, deprecated, message: "Not actually deprecated. Marked as deprecated to allow inclusion of deprecated tests (which test deprecated functionality) without warnings")
func __FIBONACCI_APPTests__allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FibonacciServiceTests.__allTests__FibonacciServiceTests)
    ]
}