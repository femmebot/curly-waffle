//
//  ViewController.swift
//  cg-estimator
//
//  Created by Phoebe Espiritu on 3/12/18.
//  Copyright © 2018 Phoebe Espiritu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // initialize variables
    var button : UIButton?
    var buttons = [UIButton?]()
    var label : UILabel?

    var allPrompts = PromptData()
    var promptLabel = UITextView.init()
    var bgContainer = UIView.init()
    var buttonBlock : UIButton?
    var counter = 0
    var currentIndex = 0
    var pickedAnswer : String = ""
    let buttonHeight = 50
    
    // vars for estimator logic
    var prodVar :  Bool = false
    var fisma : String = ""
    var numberOfSystems : Double = 0
    var memoryQuota : Double = 0
    var memoryQuotaText : String = ""
    
    // prices
    var recPackage : String = ""
    var accessFee : Double = 0.0
    var estimatedCost : Double = 0.0
    let prototypingFee = 1250.00
    let fismaLowFee = 1666.67
    let fismaModerateFee = 7500.00
    let memoryUsage = 100

    
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
    
    @objc func answerPressed(sender: UIButton){
        
        sender.setTitleColor(UIColor.red, for: .normal)

        pickedAnswer = (sender.titleLabel?.text)!
        currentIndex = counter
        selectionHandler()
        
        nextScreen()
        
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
    
    func setUpButton(buttonName : String){
        
        button = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (self.view.frame.size.width/2 - 20), y: self.view.frame.size.height - 80, width: self.view.frame.size.width - 40, height: 40))
        
        // title hex #425772
        button?.setTitle(buttonName, for: .normal)
        
        //        buttonBlock?.setTitleColor(UIColor.red, for: .normal)
        button?.setTitleColor(UIColor(
            red: 0x42/255,
            green: 0x57/255,
            blue: 0x72/255,
            alpha: 1.0), for: .normal)
        button?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        // target
        button?.addTarget(self, action: #selector(answerPressed(sender:)), for: UIControlEvents.touchUpInside)
        
        // background color #00aeef
        button?.backgroundColor = UIColor(
            red: 0x00/255,
            green: 0xae/255,
            blue: 0xef/255,
            alpha: 1.0)
        button?.layer.cornerRadius = 20
        
        // add to view
        self.view.addSubview(button!)
        
    }
    
    func setUpButtonBlock(buttonName : String, yPos : Int) {
        
        // init
        buttonBlock = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (self.view.frame.size.width/2 - 20), y: CGFloat(yPos), width: self.view.frame.size.width - 40, height: CGFloat(40)))
        

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
        buttonBlock?.addTarget(self, action: #selector(answerPressed(sender:)), for: UIControlEvents.touchUpInside)
        
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
        
        // assign tag
//        buttonIndex += 1
//        buttonBlock?.tag = buttonIndex
        
        // add to view
        self.view.addSubview(buttonBlock!)
        self.buttons.append(buttonBlock!)
        
    }
    

    func setUpPromptOptions() {
        
        let numOfArrayItems = allPrompts.list[counter].choicesArray.count
        
        for optionsItem in 0...numOfArrayItems - 1 {
            // stacked y-dist from the top
            setUpButtonBlock(buttonName:(allPrompts.list[counter].choicesArray[optionsItem] as! String), yPos: (buttonHeight * optionsItem + 190))
            
            // stacked from the bottom
//            setUpButtonBlock(buttonName:(allPrompts.list[counter].choicesArray[optionsItem] as! String), yPos: Int(self.view.frame.size.height) - (buttonHeight * (numOfArrayItems - optionsItem)) - 50)
            
//            print(allPrompts.list[counter].choicesArray[optionsItem])
            
//            print(allPrompts.list[counter].choicesSubtext?[optionsItem] ?? "")
        }
    }

    func removeButtonBlock() {
        
        for button in self.buttons {
            button?.removeFromSuperview()
        }
    }
    
    func nextScreen() {
        
        
        if counter <= 3 {
            removeButtonBlock()
            promptLabel.text = allPrompts.list[counter].promptText
            setUpPromptOptions()
        } else if counter == 4 {
            removeButtonBlock()
            displayPackageScreen()
        } else if counter == 5 {
            estimateCost()
        }

        
    }
    
    func selectionHandler() {
        
        if counter == 0 && pickedAnswer == "Yes" {
            prodVar = true
            counter += 1
            // print(prodVar)
        } else if counter == 0 && pickedAnswer == "No" {
            counter = 3
            prodVar = false
        } else if counter == 1 {
            fisma = pickedAnswer
            counter += 1
            // print("FISMA level: \(fisma)")
        } else if counter == 2 {
            numberOfSystems = Double(pickedAnswer)!
            counter += 1
            // print("No. of systems: \(numberOfSystems)")
        } else if counter == 3 {
            // ["128 MB", "512 MB", "1 GB", "2 GB", "3 GB", "5 GB"]
            memoryQuotaText = pickedAnswer
            switch pickedAnswer {
            case "128 MB":
                memoryQuota = 0.25
            case "512 MB":
                memoryQuota = 0.5
            case "1 GB":
                memoryQuota = 1
            case "2 GB":
                memoryQuota = 2
            case "3 GB":
                memoryQuota = 3
            case "5 GB":
                memoryQuota = 5
            default:
                print("memory quota default")
            }
            // print("Quota: \(memoryQuota)")
             counter = 4
        }
        
    }
    
    func displayPackageScreen() {
        
        if prodVar == false {
            recPackage = "Prototyping"
            accessFee = prototypingFee
        } else if prodVar == true && fisma == "Low" {
            recPackage = "FISMA Low"
            accessFee = fismaLowFee
        } else if prodVar == true && fisma == "Moderate" {
            recPackage = "FISMA Moderate"
            accessFee = fismaModerateFee
        }

        promptLabel.text = "Great! A \(recPackage) package is the best fit based on your needs."
        setUpButton(buttonName: "Show estimate")
        counter = 5
        
    }
    
    func estimateCost() {
        
        print ("Estimated monthly cost for \(Int(numberOfSystems)) \(recPackage) system(s) with \(memoryQuotaText) memory is \((accessFee * numberOfSystems) + (memoryQuota * 100) )")
        
        // prices
//        var recPackage : String = ""
//        var accessFee : NSDecimalNumber = 0
//        var estimatedCost : NSDecimalNumber = 0
//        let prototypingFee : NSDecimalNumber = 1250
//        let fismaLowFee : NSDecimalNumber = 1667
//        let fismaModerateFee : NSDecimalNumber = 7500
//        let memoryUsage : NSDecimalNumber = 100
        
        
        
    }
    
    
}

