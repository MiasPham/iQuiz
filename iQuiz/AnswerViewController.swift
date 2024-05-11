//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Long Nguyen on 5/9/24.
//

import UIKit

class AnswerViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showResult(_ isCorrect: Bool, correctResult: String) {
        if isCorrect {
            resultLabel.text = "Correcttttt"
        } else {
            resultLabel.text = "Errrr! Incorrect"
        }
        
        correctAnswerLabel.text = correctResult
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
