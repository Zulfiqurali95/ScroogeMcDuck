import XCTest
@testable import ScroogeMcDuck

final class NetworkRepositoryTests: XCTestCase {

    var sut: NetworkRepository?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkRepository(api: MockAPI())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testPostRequestSuccess() {
        let salary = Salary(takeHome: 200_000, fullAmount: 300_000, pensionRate: 2.1)
        let expectation = XCTestExpectation(description: "Salary post success")
        var postedSalary: Salary?
        
        sut?.post(with: salary, completion: { (result: Result<Salary, Error>) in
            switch result {
            case .success(let salary):
                postedSalary = salary
                expectation.fulfill()
            case .failure:
                XCTFail("Should not fail")
            }
        })
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(salary, postedSalary)
    }
    
    func testPostRequestFailure() {
        let salary = Salary(takeHome: 100_000, fullAmount: 300_000, pensionRate: 2.1)
        let expectation = XCTestExpectation(description: "Salary post failure")
        var error: MockError?
        
        sut?.post(with: salary, completion: { (result: Result<Salary, Error>) in
            switch result {
            case .success:
                XCTFail("Should not succeed")
                
            case .failure(let err):
                if let err = err as? MockError {
                    error = err
                }
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(error, MockError.SampleError)
    }
}
