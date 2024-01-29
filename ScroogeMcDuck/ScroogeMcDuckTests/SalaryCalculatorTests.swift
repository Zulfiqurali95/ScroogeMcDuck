import XCTest
@testable import ScroogeMcDuck

final class SalaryCalculatorTests: XCTestCase {

    var sut: SalaryCalculator?
    private let testIncome: Double = 300_000
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SalaryCalculator(network: MockNetwork())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testConversionToDouble() {
        let double = sut?.convertInputToDouble("300000")
        XCTAssertEqual(double, 300_000)
    }
    
    func testConversionToDoubleInvalidInput() {
        let double = sut?.convertInputToDouble("abcd")
        XCTAssertEqual(double, 0)
    }
    
    func testSalaryCalculationWithNoAddedPension() {
        let takeHome = sut?.calculateSalary(from: testIncome, with: .no)
        XCTAssertEqual(takeHome, "181500.0")
    }
    
    func testSalaryCalculationWithTwoPointOneAddedPension() {
        let takeHome = sut?.calculateSalary(from: testIncome, with: .twoPointOne)
        XCTAssertEqual(takeHome, "175200.0")
    }
    
    func testSalaryCalculationWithThreeAddedPension() {
        let takeHome = sut?.calculateSalary(from: testIncome, with: .three)
        XCTAssertEqual(takeHome, "172500.0")
    }

}
