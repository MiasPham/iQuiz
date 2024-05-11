//
//  QuizViewController.swift
//  iQuiz
//
//  Created by Long Nguyen on 5/9/24.
//

import UIKit

class QuizViewController: UIViewController {
    
    var questionView: QuestionViewController!
    var answerView: AnswerViewController!
    var finalView: FinalSceneViewController!
    var questions: [Question] = []
    var userAnswer: Int = 1
    var questionIdx: Int = 0
    var totalScore: Int = 0
    var isSummary: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionView = instantiate(id: "question")
        answerView = instantiate(id: "answer")
        finalView = instantiate(id: "final")
        
        isSummary = false
        
        switchViewController(nil, to: questionView)
        questionView.setQuestion(questions[questionIdx].text)
        questionView.setAnswerChoices(questions[questionIdx].answers)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_ :)), name: Notification.Name("userAnswer"), object: nil)
    }
    
    @objc func didGetNotification(_ notification: Notification) {
        userAnswer = (notification.object as! Int)
    }
    
    func setQuizQuestions(quizQuestions: [Question]) {
        questions = quizQuestions
    }
    
    func instantiate<T>(id: String) -> T! {
        return storyboard?.instantiateViewController(withIdentifier: id) as? T
    }
    
    @IBAction func switchViews(_ sender: UIButton) {
        UIView.animate(withDuration: 0.4, animations: { [self] in
            if self.questionView != nil &&
                self.questionView.view.superview != nil {
                UIView.transition(with: view, duration: 0.4, options: [
                    .curveEaseInOut, .transitionFlipFromRight
                ], animations: {
                    self.answerView.view.frame = self.view.frame
                })
                
                
                let correctResult = Int(questions[questionIdx].answer)!
                let isCorrect = userAnswer == correctResult
                //                print(userAnswer)
                answerView.showResult(isCorrect,
                                      correctResult: questions[questionIdx].answers[correctResult - 1])
                sender.setTitle("Next", for: .normal)
                switchViewController(questionView, to: answerView)
                
                if isCorrect {
                    totalScore += 1
                }
                if (questionIdx + 1) == questions.count {
                    isSummary = true
                }
            } else if self.finalView != nil && self.finalView.view.superview != nil {
                
                UIView.transition(with: view, duration: 0.4, options: [
                    .curveEaseInOut, .transitionFlipFromLeft
                ], animations: {
                    self.questionView.view.frame = self.view.frame
                })
                sender.setTitle("Submit", for: .normal)
                questionIdx = 0
                questionView.setQuestion(questions[questionIdx].text)
                questionView.setAnswerChoices(questions[questionIdx].answers)
                switchViewController(finalView, to: questionView)
                
            } else {
                if isSummary {
                    UIView.transition(with: view, duration: 0.4, options: [
                        .curveEaseInOut, .transitionFlipFromLeft
                    ], animations: {
                        self.finalView.view.frame = self.view.frame
                    })
                    sender.setTitle("Next", for: .normal)
                    finalView.showResultSummary(get: totalScore, outof: questions.count)
                    switchViewController(answerView, to: finalView)
                    isSummary = false
                    totalScore = 0
                } else {
                    UIView.transition(with: view, duration: 0.4, options: [
                        .curveEaseInOut, .transitionFlipFromLeft
                    ], animations: {
                        self.questionView.view.frame = self.view.frame
                    })
                    sender.setTitle("Submit", for: .normal)
                    questionIdx = (questionIdx + 1) % questions.count
                    questionView.setQuestion(questions[questionIdx].text)
                    questionView.setAnswerChoices(questions[questionIdx].answers)
                    switchViewController(answerView, to: questionView)
                }
            }
        })
    }
    // {{## END switch-with-animation ##}}
    
    // {{## BEGIN switchViewController ##}}
    fileprivate func switchViewController(_ from: UIViewController?, to: UIViewController) {
        // Remove the old....
        if from != nil {
            from!.willMove(toParent: nil)
            from!.view.removeFromSuperview()
            from!.removeFromParent()
        }

        // ... swap in the new
        self.addChild(to)
        self.view.insertSubview(to.view, at: 0)
        to.didMove(toParent: self)
    }
    
     @IBAction func backBtnAction(_ sender: UIButton) {
         dismiss(animated: true)
     }

}
