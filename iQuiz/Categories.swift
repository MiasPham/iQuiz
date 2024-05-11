//
//  Categories.swift
//  iQuiz
//
//  Created by Mia Pham on 5/6/24.
//

import UIKit

struct Categories: Decodable {
    let title: String
    let desc: String
    let questions: [Question]
}

struct Question: Decodable {
    let text: String
    let answer: String
    let answers: [String]
}
