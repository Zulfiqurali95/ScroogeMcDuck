import Foundation

enum PensionOption: Int {
    case no = 0
    case twoPointOne
    case three
}

protocol SalaryCalculating {
    func calculateSalary(from number: Double, with pensionOption: PensionOption) -> String
    func convertInputToDouble(_ input: String?) -> Double
}

// This is effectively a viewmodel
class SalaryCalculator: SalaryCalculating {
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func calculateSalary(from number: Double, with pensionOption: PensionOption) -> String {
        var rate: Double
        
        switch pensionOption {
        case .twoPointOne:
            rate = 0.021
        case .three:
            rate = 0.03
        default:
            rate = 0
        }
        
        let pensionRate = 0.1252 + rate
        let takeHome = (number - (number * 0.2) - (number * 0.0698) - (number * pensionRate)).rounded()
        let salary = Salary(takeHome: takeHome, fullAmount: number, pensionRate: pensionRate)
        
        sendTaxInfoToSodra(salary: salary)
        
        return String(takeHome)
    }

    private func sendTaxInfoToSodra(salary: Salary) {
        print("Sending to Sodra... \(salary.takeHome)")
        network.post(with: salary) { (result: Result<Salary, Error>) in
            switch result {
            case .success(let salary):
                print("Finished sending to Sodra... \(salary.takeHome)")
            case .failure(let error):
                print("Finished sending to Sodra... Error: \(error)")
            }
        }
    }
    
    func convertInputToDouble(_ input: String?) -> Double {
        return Double(input ?? "0") ?? 0
    }
}
