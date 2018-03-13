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
    var buttonBlock : UIButton?
    var counter = 3
    
    let buttonHeight = 50

    
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
        // #f1f6fc
        bgContainer.backgroundColor = UIColor(
            red: 0xf1/255,
            green: 0xf6/255,
            blue: 0xfc/255,
            alpha: 1.0)
        self.view.addSubview(bgContainer)
    }
    
    func setUpPromptLabel() {
        
        promptLabel.frame = CGRect(x:20,y:40,width:self.view.frame.size.width - 40,height: 100)
        promptLabel.font = UIFont.boldSystemFont(ofSize: 16)
        promptLabel.textColor = UIColor(
            red: 0x42/255,
            green: 0x57/255,
            blue: 0x72/255,
            alpha: 1.0)
        
        let firstPrompt = allPrompts.list[counter]
        promptLabel.text = firstPrompt.promptText
        
        self.view.addSubview(promptLabel)
        
    }
    func setUpButtonBlock(buttonName : String, yPos : Int) {
        
        // init
        buttonBlock = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (self.view.frame.size.width/2 - 20), y: CGFloat(yPos), width: self.view.frame.size.width - 40, height: CGFloat(buttonHeight)))
        
        // title hex #425772
        buttonBlock?.setTitle(buttonName, for: .normal)
//        buttonBlock?.setTitleColor(UIColor.red, for: .normal)
        buttonBlock?.setTitleColor(UIColor(
            red: 0x42/255,
            green: 0x57/255,
            blue: 0x72/255,
            alpha: 1.0), for: .normal)
        buttonBlock?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        buttonBlock?.contentHorizontalAlignment = .left
        
        // Hex to UIColor converter http://uicolor.xyz/#/hex-to-ui
        //        button?.setTitleColor(UIColor(red:0.01, green:0.42, blue:0.92, alpha:1.0), for: .normal)
        
        // target
//        buttonBlock?.addTarget(self, action: #selector(answerPressed(sender:)), for: UIControlEvents.touchUpInside)
        
        // background color #e6e6e6
//         buttonBlock?.backgroundColor = UIColor.lightGray
//            buttonBlock?.backgroundColor = UIColor(
//                red: 0xe6/255,
//                green: 0xe6/255,
//                blue: 0xe6/255,
//                alpha: 1.0)
        
        // border #ff5235
//        buttonBlock?.layer.borderWidth = 1
//        buttonBlock?.layer.borderColor = UIColor(
//            red: 0xff/255,
//            green: 0x52/255,
//            blue: 0x35/255,
//            alpha: 1.0).cgColor
        
        // image
        // buttonBlock?.setImage(UIImage.init(named: "image.png"), for: UIControlState.normal)
        
        // bottom border
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(
            red: 0x42/255,
            green: 0x57/255,
            blue: 0x72/255,
            alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: (buttonBlock?.frame.size.height)! - width, width:  (buttonBlock?.frame.size.width)!, height: (buttonBlock?.frame.size.height)!)

        border.borderWidth = width
        buttonBlock?.layer.addSublayer(border)
        buttonBlock?.layer.masksToBounds = true
        
        
        // add to view
        self.view.addSubview(buttonBlock!)
        
    }
    

    func setUpPromptOptions() {
        
        let numOfArrayItems = allPrompts.list[counter].choicesArray.count
        
        for optionsItem in 0...numOfArrayItems - 1 {
            setUpButtonBlock(buttonName:(allPrompts.list[counter].choicesArray[optionsItem] as! String), yPos: Int(self.view.frame.size.height) - (buttonHeight * (numOfArrayItems - optionsItem)) - 50)
            print(allPrompts.list[counter].choicesArray[optionsItem])
            print(allPrompts.list[counter].choicesSubtext?[optionsItem] ?? "")
        }
    }
    
}

