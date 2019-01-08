//
//  ViewController.swift
//  BarChart
//
//  Created by Chinonso Obidike on 1/7/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var barView: UITextView!
    
    @IBOutlet weak var reportView: UITextView!
    
    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var inputTextField: UITextField!
    
  //declare global variables
    var i = 1
    var points = 0
    var allScores = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Introduction.
        instructionLabel.text = "This app gives you a bar chart for your\nscore points"
        reportView.text = "How many scores points do you want to enter?"
        inputTextField.placeholder = "Enter number of scores"
    }
    
    @IBAction func enterButton(_ sender: UIButton) {
        instructionLabel.text = ""
        sender.tag += 1
        if sender.tag < 2 || points > 10{ //confirm that number of points entred is not more than 10 or less than 1
            inputTextField.placeholder = "Enter number of scores"
            let point = getNumberOfPoints()
            if point > 10 || points < 1{
                instructionLabel.textColor = .red
                instructionLabel.text = "⚠️ No of scores must not exceed 10"
                sender.tag == 0
            }
        } else {                            //get scores for each point
            inputTextField.placeholder = "Enter scores for \(String(i + 1))"
            instructionLabel.textColor = UIColor(red: 0.734, green: 0.307, blue: 0.251, alpha: 1)
            instructionLabel.text = "Enter scores for \(String(i + 1))"
            getScorePoints()
            if i > points {            //ensure the number of scores entered does not exceed number of points
                sender.isUserInteractionEnabled = false
                inputTextField.resignFirstResponder();
                displayBarChart(storeSales: self.allScores)
            }
        }
    }
    
    //function that gets number of points 
    func getNumberOfPoints() -> Int {
        points = Int(inputTextField.text!)!
         reportView.text = ""
        return points
    }
    
    //function that gets the score points
    func getScorePoints() {
        inputTextField.placeholder = "Enter scores for \(String(i + 1))"
        var amount: Int = 0
        amount = Int(inputTextField.text!)!
        
        //`ensure score entered is between 100 and 3000
        if amount < 100 {
            instructionLabel.textColor = .red
            instructionLabel.text = "⚠️ Score points cannot be less than 100"
            return
        } else if amount > 3000 {
            instructionLabel.textColor = .red
            instructionLabel.text = "⚠️ Score points cannot be more than 3,000"
            return
        } else {
            instructionLabel.textColor = UIColor(red: 0.734, green: 0.307, blue: 0.251, alpha: 1)
            instructionLabel.adjustsFontSizeToFitWidth = true
            instructionLabel.text = "Score points for \(String(i + 1))"
            amount = Int(inputTextField.text!)!
            self.allScores.append(amount)
            reportView.text += "Score points for \(i): \(String(amount))\n"
            i += 1
        }
    }
    
    //function takes the array of points entered and displays bar chart per 100
    func displayBarChart(storeSales: [Int]){
        var count1: Int = 1
        var count2: Int = 1
        var amount: Double = 0.0
        var average: Double = 0.0
        var bar: Int = 0
        var assignedStoreSales = [String: Int]()
        for store in storeSales{
            assignedStoreSales["score\(count1)"] = store
            amount += Double(store)
            count1 += 1
        }
        average = amount/Double(storeSales.count)
        reportView.text += "Your average score is: \(average)"
        barView.text = "SCORE BAR CHART:\n"
        for (_, report) in assignedStoreSales {
            bar = report/100
            barView.text += "Score \(count2): "
            print("Score \(count2): ")
           
            for _ in 0..<bar {
                barView.text += "*"
                print("*")
            }
            barView.text += "\n"
            count2 += 1
        }
        
        
        
    }
}



