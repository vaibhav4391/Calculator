//
//  CalculatorVC.swift
//  flytbaseDemo
//
//  Created by vaibhav bhosale on 20/08/20.
//  Copyright © 2020 VB. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {
    
    @IBOutlet weak var lblOutput: UILabel!
    @IBOutlet weak var lblCalcaulation: UILabel!
    @IBOutlet weak var btnZero: UIButton!
    @IBOutlet weak var btnMultiply: UIButton!
    @IBOutlet weak var btnDevide: UIButton!
    @IBOutlet weak var btnMunus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet var historyView: UIView!
    @IBOutlet weak var tblHistory: UITableView!
    
    var strCalcaulation : String!
    private var calOperation = CalculatorOperation()
    
    var arrCalculator:[[String:String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrCalculator = [[String:String]]()
        calOperation.countOnMeDelegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        btnDevide.setCircule()
        btnPlus.setCircule()
        btnMultiply.setCircule()
        btnMunus.setCircule()
        btnZero.setCircule()
    }
    
    @IBAction func btnOperationClickAction(_ sender: UIButton) {
        let operationsymbol = sender.currentTitle
        if operationsymbol == "AC" {
            lblCalcaulation.text = "0"
            lblOutput.text = ""
            calOperation.clear()
        }
        else {
            switch operationsymbol {
            case "+":
                calOperation.plus()
            case "-":
                calOperation.minus()
            case "×":
                calOperation.multiply()
            case "÷":
                calOperation.divide()
            case "=":
                self.lblOutput.text = lblCalcaulation.text!.match()
                self.arrCalculator.append(["calculationOf":lblCalcaulation.text!, "result":"=\(lblOutput.text!)"])
                self.tblHistory.reloadData()
            case "±":
                print("±")
            default:
                break
            }
        }
    }
    
    @IBAction func btnDigitClickAction(_ sender: UIButton) {
        let digit = sender.currentTitle!
        calOperation.addNewNumber(Int(digit)!)
    }
    
    @IBAction func btnHistoryClickAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.historyView.frame = self.view.frame
            self.view.addSubview(self.historyView)
            self.tblHistory.reloadData()
        }
    }
    
    @IBAction func btnCloseClickAction(_ sender: Any) {
        self.historyView.removeFromSuperview()
    }
}

//Calculator History
extension CalculatorVC: CountOnMeDelegate {
    func updateCal(strCalulation: String) {
        lblCalcaulation.text = strCalulation
    }
    
    func updateOutput(strOutput: String) {
        if let output:String = Optional.some(strOutput as String), output != "" {
            lblOutput.text = output
            self.arrCalculator.append(["calculationOf":lblCalcaulation.text!, "result":"=\(lblOutput.text!)"])
        }
    }
}

extension CalculatorVC:UITableViewDelegate,UITableViewDataSource{
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCalculator?.count ?? 0
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HistoryTVCell = tableView.dequeueReusableCell(withIdentifier: String(describing: HistoryTVCell.self)) as! HistoryTVCell
        cell.lblCalculationOf.text = (arrCalculator[indexPath.row])["calculationOf"]
        cell.lblResult.text = (arrCalculator[indexPath.row])["result"]
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
