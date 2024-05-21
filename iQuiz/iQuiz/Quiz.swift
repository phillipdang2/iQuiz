//
//  Quiz.swift
//  iQuiz
//
//  Created by Phillip Dang on 5/20/24.
//

import Foundation

struct testQuiz: Codable, Identifiable {
    let id = UUID()
    let title: String
    let desc: String
}

struct Quiz: Codable, Identifiable {
    let id = UUID()
    let title: String
    let desc: String
    let questions: [Question]
    
    enum CodingKeys: String, CodingKey {
        case title
        case desc = "desc"
        case questions
    }
}

struct Question: Codable, Identifiable {
    let id = UUID()
    let text: String
    let answer: String
    let answers: [String]
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case answer = "answer"
        case answers = "answers"
    }
}
