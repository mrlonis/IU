//
//  FlashCardModel.swift
//  FlashCards
//
//  Created by Matthew Lonis on 2/16/18.
//  Copyright © 2018 Matthew Lonis. All rights reserved.
//

import Foundation

class FlashCardModel {
    
    var questionArray : Dictionary = [0: "What is your name?",
                                      1: "What is 42?",
                                      2: "What is the color of the sky?"];
    
    var answersArray : Dictionary = [0: "My name is not important.",
                                     1: "It's 6 times 7.",
                                     2: "Kinda gray today."];
    
    var currentQuestionIndex : Int = 0;
    
    init() {
        
    }
    
    func getNextQuestion() -> String {
        currentQuestionIndex += 1;
        
        if (currentQuestionIndex >= questionArray.count) {
            currentQuestionIndex = 0;
        }
        
        return questionArray[currentQuestionIndex]!;
    }
    
    func getAnswer() -> String {
        return answersArray[currentQuestionIndex]!;
    }
}
