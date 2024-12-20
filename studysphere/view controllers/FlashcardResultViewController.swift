//
//  FlashcardResultViewController.swift
//  studysphere
//
//  Created by dark on 18/11/24.
//

import UIKit

class FlashcardResultViewController: UIViewController {
    
    var memorised:Float = 0
    var needPractice:Float = 0
    @IBOutlet weak var memorisedL: UILabel!
    @IBOutlet weak var needPracticeL: UILabel!
    @IBOutlet weak var percentageL: UILabel!
    @IBOutlet weak var youGot: UILabel!
    @IBOutlet weak var thatsBetter: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // make left navigation button
        let leftButton = UIBarButtonItem(title:"Schedule",style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
        let total = memorised + needPractice
        youGot.text = "You got \(memorised)/\(total) questions Correct"
        thatsBetter.text = "That's better than \(Int(memorised/(total)*100))% of means"
       
    }
    @objc func backButtonTapped() {
        performSegue(withIdentifier: "toScheduleUnwind", sender: nil)
    }
    
    @IBAction func goBack(_ sender: Any) {
        performSegue(withIdentifier: "toScheduleUnwind", sender: nil)
    }
    
}
