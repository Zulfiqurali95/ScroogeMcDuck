import Foundation
@testable import ScroogeMcDuck

class MockNetwork: Network {
    func post<T>(with model: T, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            guard let salary = Salary(takeHome: 12, fullAmount: 12, pensionRate: 0) as? T else {
                completion(.failure(NSError(domain: "Test Error", code: 0)))
                return
            }
            completion(.success(salary))
        }
    }
    
    func get<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {}
    func update<T>(with model: T, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {}
    func delete(completion: @escaping (Result<Data?, Error>) -> Void) {}
}
