//
//  ViewController.swift
//  iQuiz
//
//  Created by Mia Pham on 4/29/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var settings: UIToolbar!
    
//    private var url = "http://tednewardsandbox.site44.com/questions.json"
    
    private var categories: [Categories] = []

//    private var selectedCategoryIndex: Int?
    
//    let data: [Categories] = [
//        Categories(title: "Mathematics", imgName: "math_logo", description: "Test your mathematical skills with our engaging trivia quiz, packed with fun and challenging questions."),
//        Categories(title: "Marvel Super Heroes", imgName: "marvel_logo", description: "Test your Marvel skills with our engaging trivia quiz, packed with fun and challenging questions."),
//        Categories(title: "Science", imgName: "science_logo", description: "Test your science skills with our engaging trivia quiz, packed with fun and challenging questions."),
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        fetch("http://tednewardsandbox.site44.com/questions.json")
    }
    
    //Get data from JSON file
    func fetch(_ url: String = "http://tednewardsandbox.site44.com/questions.json") {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid response")
                    return
                }
            
//            let string = String(data: data!, encoding: .utf8)!
//            print("Data returned is \(string)")
            
            guard let jsonData = data else {
                print("No data received")
                return
            }
            
            do {
                self.categories = try JSONDecoder().decode([Categories].self, from: jsonData)
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
//                print(self.categories.first?.questions)
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        task.resume()
    }
    
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Fetching data
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let category = categories[indexPath.row]
        cell.label.text = category.title
        cell.label_desc.text = category.desc

        
        // Map category titles to image names
        let imgName: String
        switch category.title {
        case "Marvel Super Heroes":
            imgName = "marvel_logo"
        case "Mathematics":
            imgName = "math_logo"
        case "Science!":
            imgName = "science_logo"
        default:
            imgName = ""
        }
        cell.imgView.image = UIImage(named: imgName)
        return cell
    }
    
    //Settings alert
    @IBAction func settingsTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Update", message: "Input URL below", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addTextField { (textField) in
            textField.placeholder = "URL"
        }
        alert.addAction(UIAlertAction(title: "Check Now", style: .default) {UIAlertAction in
            let url = (alert.textFields![0] as UITextField).text
                //***Have not implemented GetData yet***
            if (url == nil || url == "") {
                self.fetch()
            } else {
                self.fetch(url!)
            }
            self.table.reloadData()
        })
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath) selected")
        let quizIndex = indexPath[1]
        let quizViewController = self.storyboard!.instantiateViewController(withIdentifier: "quiz") as! QuizViewController
        quizViewController.setQuizQuestions(quizQuestions: self.categories[quizIndex].questions)
        self.present(quizViewController, animated: true, completion: nil)
    }
    
    //Space the cells evenly throughout the screen
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}
