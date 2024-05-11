//
//  FinalSceneViewController.swift
//  iQuiz
//
//  Created by Long Nguyen on 5/9/24.
//

import UIKit

class FinalSceneViewController: UIViewController {

    @IBOutlet weak var compliment: UILabel!
    @IBOutlet weak var resultSummary: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showResultSummary(get: Int, outof: Int) {
        if get == outof {
            compliment.text = "Perfect!"
        } else {
            compliment.text = "Almost There!"
        }
        resultSummary.text = "You got \(get) out of \(outof) correct"
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
