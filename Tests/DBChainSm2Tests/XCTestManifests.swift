import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DBChainSm2Tests.allTests),
    ]
}
#endif
