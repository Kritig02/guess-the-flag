//
//  ViewController.swift
//  Guess the flag
//
//  Created by Kriti on 2023-09-30.
//

import UIKit

class ViewController: UIViewController {
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionNumber = 1
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestions(action: nil)
    }
    func askQuestions(action: UIAlertAction!){
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = "Round \(questionNumber): " + countries[correctAnswer].uppercased() + " | Score: \(score)"
    }
    
    func playAgain(action: UIAlertAction!){
        questionNumber = 1
        score = 0
        correctAnswer = 0
        askQuestions(action: nil)
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if questionNumber < 10 {
            questionNumber += 1
            if sender.tag == correctAnswer {
                title = "That's right!"
                score += 1
            }else {
                title = "Boo! That's the flag of \(countries[sender.tag].uppercased())"
                if score > 0 {
                    score -= 1
                }else {
                    score = 0
                }
            }
            
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestions))
            present(ac, animated: true)
        } else {
            let ac2 = UIAlertController(title: "Game Over", message: "Your final score is \(score)", preferredStyle: .alert)
            ac2.addAction(UIAlertAction(title: "Start again", style: .default, handler: playAgain))
            present(ac2, animated: true)
        }
        
    }
}

