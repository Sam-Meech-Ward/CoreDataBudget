//
//  ViewController.swift
//  BudgetData
//
//  Created by Sam Meech-Ward on 2020-06-01.
//  Copyright © 2020 meech-ward. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController {

  @IBOutlet weak var budgetTitleTextField: UITextField!
  @IBOutlet weak var budgetAmountTextField: UITextField!
  
  @IBOutlet weak var tableView: UITableView!
  
  var budgets: [Any] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func saveNewBudget(_ sender: Any) {
    guard let budgetTitle = budgetTitleTextField.text else {
      print("Invalid title")
      return
    }
    guard let budgetAmountText = budgetAmountTextField.text else {
      print("Invalid amount")
      return
    }
    let budgetAmount = NSDecimalNumber(string: budgetAmountText)
    
    budgetTitleTextField.text = ""
    budgetAmountTextField.text = ""
    
    // Save new budget
  }
  
  @IBSegueAction func openExpenses(_ coder: NSCoder) -> ExpenseViewController? {
    let vc = ExpenseViewController(coder: coder)
    
    guard let indexPath = tableView.indexPathForSelectedRow else {
      return vc
    }
    
    let budget = budgets[indexPath.row]
    vc?.budget = budget
    
    tableView.deselectRow(at: indexPath, animated: true)
    
    return vc
  }
}

extension BudgetViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    budgets.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let budget = budgets[indexPath.row]

    return cell
  }
  
}
