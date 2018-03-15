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
    let memoryUsageCost = 105.00
    let bundle5FismaLow = 7500.00
    let bundle10FismaLow = 14166.67
    let bundle15FismaLow = 20000.00
    let bundle5FismaModerate = 33750.00
    let bundle10FismaModerate = 63750.00
    let bundle15FismaModerate = 90000.00
    
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
        
        bgContainer.frame = CGRect(x:0, y:160, width:self.view.frame.size.width, height: self.view.frame.size.height - 160)
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
            red: 0xff/255,
            green: 0xff/255,
            blue: 0xff/255,
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
            displayEstimateScreen()
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
        
        // switch to bundle pricing
        if numberOfSystems == 5 && accessFee == fismaLowFee {
            accessFee = bundle5FismaLow
        } else if numberOfSystems == 10 && accessFee == fismaLowFee {
            accessFee = bundle10FismaLow
        } else if numberOfSystems == 15 && accessFee == fismaLowFee {
            accessFee = bundle15FismaLow
        } else if numberOfSystems == 5 && accessFee == fismaModerateFee {
            accessFee = bundle5FismaModerate
        } else if numberOfSystems == 10 && accessFee == fismaModerateFee {
            accessFee = bundle10FismaModerate
        } else if numberOfSystems == 15 && accessFee == fismaModerateFee {
            accessFee = bundle15FismaModerate
        }

        promptLabel.text = "Great! A \(recPackage) package is the best fit based on your needs."
        setUpButton(buttonName: "Show estimate")
        counter = 5
        
    }
    
    func displayEstimateScreen() {
        
        // set up screen title
        promptLabel.removeFromSuperview()
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x:20,y:0,width:self.view.frame.size.width - 40,height: 100)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor(
            red: 0x42/255,
            green: 0x57/255,
            blue: 0x72/255,
            alpha: 1.0)
        titleLabel.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        titleLabel.text = "Estimate"
        self.view.addSubview(titleLabel)
        
        // set up background
        bgContainer.removeFromSuperview()
        view.backgroundColor = UIColor(
            red: 0xf1/255,
            green: 0xf6/255,
            blue: 0xfc/255,
            alpha: 1.0)
        
        // set up buttons
        button?.removeFromSuperview()
        setUpButton(buttonName: "Start again")
        // #e6e5e3
        button?.backgroundColor = UIColor(
            red: 0xff/255,
            green: 0xff/255,
            blue: 0xff/255,
            alpha: 1.0)
        button?.setTitleColor(UIColor(
            red: 0xe6/255,
            green: 0xe5/255,
            blue: 0xe3/255,
            alpha: 1.0), for: .normal)
        
        
        // set up labels
        setUpEstimatorLabel(labelName: "Package", xPos: 20, yPos: 100)
        setUpEstimatorLabel(labelName: "Quantity", xPos: 20, yPos: 180)
        setUpEstimatorLabel(labelName: "Add memory usage quota \n$105 / GB per month", xPos: 20, yPos: 270)
        setUpEstimatorLabel(labelName: "Total", xPos: 20, yPos: 390)
        
        setUpEstimateResults(labelName: recPackage, xPos: 20, yPos: 112)
        setUpEstimateResults(labelName: String(numberOfSystems), xPos: 20, yPos: 192)
        setUpEstimateResults(labelName: String(memoryQuotaText), xPos: 20, yPos: 292)
        
        if numberOfSystems < 5 {
            setUpEstimatorLabel(labelName: "Cost/month", xPos: 250, yPos: 100)
            setUpEstimateResults(labelName: ("$\(String(accessFee))"), xPos: 250, yPos: 112)
        } else {
            setUpEstimatorLabel(labelName: "Discounted bulk price", xPos: 250, yPos: 180)
            setUpEstimateResults(labelName: ("$\(String(accessFee))"), xPos: 250, yPos: 192)
        }

        setUpEstimateResults(labelName: "\(recPackage),\n\(numberOfSystems) systems,\n\(memoryQuotaText) RAM", xPos: 20, yPos: 432)
        
        estimateCost()
        setUpEstimateResults(labelName: ("$\(String(estimatedCost))"), xPos: 250, yPos: 412)
        
        
    }
    
    func estimateCost() {
        
        if numberOfSystems == 1 {
            
            print ("Estimated monthly cost for 1 \(recPackage) system with \(memoryQuotaText) memory is \((accessFee) + (memoryQuota * memoryUsageCost) )")
            
            estimatedCost = ((accessFee) + (memoryQuota * memoryUsageCost) )

        } else if numberOfSystems > 1 && numberOfSystems < 5 {
            
            print ("Estimated monthly cost for \(Int(numberOfSystems)) \(recPackage) systems with \(memoryQuotaText) memory quota is \((accessFee * numberOfSystems) + (memoryQuota * memoryUsageCost) )")
            print ("Estimated cost for one year is \((accessFee * numberOfSystems) + (memoryQuota * memoryUsageCost) * 12 )")

            estimatedCost = ((accessFee * numberOfSystems) + (memoryQuota * memoryUsageCost))

        } else if numberOfSystems == 5 && recPackage == "FISMA Low" {
            
            print ("Estimated monthly cost for 5 \(recPackage) systems with \(memoryQuotaText) memory quota is \(bundle5FismaLow + (memoryQuota * memoryUsageCost))")
            
            estimatedCost = (bundle5FismaLow + (memoryQuota * memoryUsageCost))
            
        } else if numberOfSystems == 5 && recPackage == "FISMA Moderate" {
            
            print ("Estimated monthly cost for 5 \(recPackage) systems with \(memoryQuotaText) memory quota is \(bundle5FismaModerate + (memoryQuota * memoryUsageCost))")

            estimatedCost = (bundle5FismaModerate + (memoryQuota * memoryUsageCost))
            
        } else if numberOfSystems == 10 && recPackage == "FISMA Low" {
            
            print ("Estimated monthly cost for 10 \(recPackage) systems with \(memoryQuotaText) memory quota is \(bundle10FismaLow + (memoryQuota * memoryUsageCost))")
            
            estimatedCost = (bundle10FismaLow + (memoryQuota * memoryUsageCost))
            
        } else if numberOfSystems == 10 && recPackage == "FISMA Moderate" {
            
            print ("Estimated monthly cost for 10 \(recPackage) systems with \(memoryQuotaText) memory quota is \(bundle10FismaModerate + (memoryQuota * memoryUsageCost))")
            
            estimatedCost = (bundle10FismaModerate + (memoryQuota * memoryUsageCost))

        } else if numberOfSystems == 15 && recPackage == "FISMA Low" {
           
            print ("Estimated monthly cost for 15 \(recPackage) systems with \(memoryQuotaText) memory quota is \(bundle15FismaLow + (memoryQuota * memoryUsageCost))")
            
            estimatedCost = (bundle15FismaLow + (memoryQuota * memoryUsageCost))
            
        } else if numberOfSystems == 15 && recPackage == "FISMA Moderate" {
            
            print ("Estimated monthly cost for 15 \(recPackage) systems with \(memoryQuotaText) memory quota is \(bundle15FismaModerate + (memoryQuota * memoryUsageCost))")
            
            estimatedCost = (bundle15FismaModerate + (memoryQuota * memoryUsageCost))

        }
        print ("Estimated cost: \(estimatedCost)")
    }
    
    func setUpEstimatorLabel(labelName : String, xPos : Int, yPos : Int) {
    
        // init
        let label = UILabel.init()
        label.frame = CGRect(x:(xPos),y:(yPos),width:150,height: 36)
        label.text = labelName
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.black
        self.view.addSubview(label)
        
    }
    
    func setUpEstimateResults(labelName : String, xPos : Int, yPos : Int){
        let label = UILabel.init()
        label.frame = CGRect(x:(xPos),y:(yPos),width:150,height: 60)
        label.text = labelName
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.black
        self.view.addSubview(label)
    }
    
}

