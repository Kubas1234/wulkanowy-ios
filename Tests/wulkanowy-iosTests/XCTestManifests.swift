import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(wulkanowy_iosTests.allTests),
    ]
}
#endif
