import Foundation
@testable import ScroogeMcDuck

enum MockError: Error, Equatable {
    case SampleError
}

class MockAPI: API {
    func post(data: Data, session: URLSession, completion: @escaping (Result<Data, Error>) -> Void) {
        let salary = try? JSONDecoder().decode(Salary.self, from: data)
        // Not a great way to do this, but works for a basic pass/fail case
        if salary?.takeHome == 200_000 {
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                completion(.success(data))
            }
        } else {
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                completion(.failure(MockError.SampleError))
            }
        }
    }
}
