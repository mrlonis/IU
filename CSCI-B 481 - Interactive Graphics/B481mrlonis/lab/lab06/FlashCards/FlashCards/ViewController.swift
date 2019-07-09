//
//  ViewController.swift
//  FlashCards
//
//  Created by Matthew Lonis on 2/16/18.
//  Copyright © 2018 Matthew Lonis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var questionTextField: UILabel!
    @IBOutlet weak var answerTextField: UILabel!
    
    @IBAction func getQuestion(_ sender: UIButton) {
        let question : String = myFlashCardModel.getNextQuestion();
        
        questionTextField.text = question;
        answerTextField.text = "guess...";
    }
    
    @IBAction func getAnswer(_ sender: UIButton) {
        let answer = myFlashCardModel.getAnswer();
        
        answerTextField.text = answer;
    }
    
    let myFlashCardModel = FlashCardModel();
    var aQuestionIsAsked = false;
    
    
    override func viewDidLoad() {
        self.navigationController?.isToolbarHidden = false;
        self.navigationController?.isNavigationBarHidden = false;
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

