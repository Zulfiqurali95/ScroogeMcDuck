import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var salaryInputTextField: UITextField!
    @IBOutlet weak var takeHomeSalaryLabel: UILabel!
    @IBOutlet weak var additionalPensionOption: UISegmentedControl!
    
    private let calculator: SalaryCalculating = SalaryCalculator(network: NetworkRepository(api: SodraAPI.defaultPath))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        salaryInputTextField.placeholder = "Enter salary on paper"
        salaryInputTextField.keyboardType = .numberPad
        salaryInputTextField.delegate = self
        additionalPensionOption.removeAllSegments()
        additionalPensionOption.insertSegment(withTitle: "No", at: 0, animated: true)
        additionalPensionOption.insertSegment(withTitle: "2.1 %", at: 1, animated: true)
        additionalPensionOption.insertSegment(withTitle: "3 %", at: 2, animated: true)
        additionalPensionOption.selectedSegmentIndex = 0
        takeHomeSalaryLabel.textAlignment = .center
        takeHomeSalaryLabel.textColor = .systemGreen
        takeHomeSalaryLabel.font = takeHomeSalaryLabel.font.withSize(60)
        takeHomeSalaryLabel.text = ""
        
        salaryInputTextField.addTarget(self,
                                       action: #selector(salaryInputTextFieldDidChange(textField:)),
                                       for: .editingChanged)
        additionalPensionOption.addTarget(self,
                                          action: #selector(additionalPensionSelected(sender:)),
                                          for: .valueChanged)
    }
    
    @objc
    func salaryInputTextFieldDidChange(textField: UITextField) {
        evaluateSalary()
    }
    
    @objc
    func additionalPensionSelected(sender: UISegmentedControl) {
        evaluateSalary()
    }
    
    private func evaluateSalary() {
        let textNumber = calculator.convertInputToDouble(salaryInputTextField.text)
        takeHomeSalaryLabel.text = calculator.calculateSalary(from: textNumber, with: PensionOption(rawValue: additionalPensionOption.selectedSegmentIndex) ?? PensionOption.no)
    }
}

extension CalculatorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

