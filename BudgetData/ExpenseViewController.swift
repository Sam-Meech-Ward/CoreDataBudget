//
//  ExpenseViewController.swift
//  BudgetData
//
//  Created by Sam Meech-Ward on 2020-06-01.
//  Copyright © 2020 meech-ward. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController {
  
  var budget: Any?
  
  @IBOutlet weak var budgetLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var spentLabel: UILabel!
  
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var expenseTextField: UITextField!
  @IBOutlet weak var amountTextfield: UITextField!
  
  private var expenses: [Any] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    if let budget = budget {

    }
  }
  
  @IBAction func saveNewExpense(_ sender: Any) {
    guard let budget = budget else {
      return
    }
    guard let name = expenseTextField.text else {
      print("Invalid title")
      return
    }
    guard let amountText = amountTextfield.text else {
      print("Invalid amount")
      return
    }
    
    let amount = NSDecimalNumber(string: amountText)

    // save new expense
  }
  
}


extension ExpenseViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return expenses.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    return cell
  }
  
}
