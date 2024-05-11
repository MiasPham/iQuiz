//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Mia Pham on 5/8/24.
//

import UIKit

class QuestionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var ansPicker: UIPickerView!
    var choices: [String] = []
//    @IBOutlet weak var submitBtn: UIButton!
    
    var questionsData: [Categories] = []    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ansPicker.delegate = self
        self.ansPicker.dataSource = self
    }
    
    func setQuestion(_ question: String) {
//        print(question)
        questionLabel.text = question
    }
    
    func setAnswerChoices(_ answerChoices: [String]) {
        choices = answerChoices
//        print(choices)
        ansPicker.reloadAllComponents()
        ansPicker.selectRow(0, inComponent: 0, animated: false)
        NotificationCenter.default.post(name: Notification.Name("userAnswer"), object: 1)
    }
    
    //Number of data column
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows in picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        NotificationCenter.default.post(name: Notification.Name("userAnswer"), object: (row + 1))
    }
}
