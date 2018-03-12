//
//  ViewController.swift
//  cg-estimator
//
//  Created by Phoebe Espiritu on 3/12/18.
//  Copyright © 2018 Phoebe Espiritu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var allPrompts = PromptData()
    var promptLabel = UITextView.init()
    var bgContainer = UIView.init()
    var counter = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpBGContainer()
        setUpPromptLabel()
        setUpPromptOptions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpBGContainer() {
        bgContainer.frame = CGRect(x:0,y:160,width:self.view.frame.size.width,height: self.view.frame.size.height - 160)
        bgContainer.backgroundColor = UIColor(
            red: 0xf7/255,
            green: 0xf7/255,
            blue: 0xf6/255,
            alpha: 1.0)
        self.view.addSubview(bgContainer)
    }
    
    func setUpPromptLabel() {
        
        promptLabel.frame = CGRect(x:20,y:40,width:self.view.frame.size.width - 40,height: 100)
        promptLabel.font = UIFont.systemFont(ofSize: 16)
        promptLabel.textColor = UIColor.black
        
        let firstPrompt = allPrompts.list[counter]
        promptLabel.text = firstPrompt.promptText
        
        self.view.addSubview(promptLabel)
        
    }
    
    func setUpPromptOptions() {

        for optionsItem in 0...allPrompts.list[counter].choicesArray.count-1 {
            print(allPrompts.list[counter].choicesArray[optionsItem])
            print(allPrompts.list[counter].choicesSubtext?[optionsItem] ?? "")
        }
    }
    
}

