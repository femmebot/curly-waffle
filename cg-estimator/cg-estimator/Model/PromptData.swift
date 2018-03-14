//
//  PromptData.swift
//  cg-estimator
//
//  Created by Phoebe Espiritu on 3/12/18.
//  Copyright © 2018 Phoebe Espiritu. All rights reserved.
//

import Foundation

class PromptData {
    
    var list = [Prompt]()
    
    init(){
        
        // let q = Prompt(text: String, optionsArray: Array<Any>, optionsSubtext: Array<String>)
        
        // Create a prompt item and append it to the list
        let item = Prompt(text: "Do you need to host production data?", optionsArray: ["Yes", "No"], optionsSubtext: ["I need hosting for production data.", "Not yet. I want to run test apps with non-production data."] )
        
        // Add prompt to the list of prompts
        list.append(item)
        
//        list.append(Prompt(text: "Do your apps handle sensitive data and require high availability?", optionsArray: ["Low", "Moderate"], optionsSubtext: ["Applications do not collect or store sensitive data. Not required to be highly available.", "Some sensitive data is used or collected. Apps require high availability."]))
        
        list.append(Prompt(text: "FISMA Low or FISMA Moderate?", optionsArray: ["Low", "Moderate"], optionsSubtext: ["Applications do not collect or store sensitive data. Not required to be highly available.", "Some sensitive data is used or collected. Apps require high availability."]))
        
        list.append(Prompt(text: "How many systems will you need?", optionsArray: ["1", "2", "3", "5", "10", "15"], optionsSubtext: []))
        
        list.append(Prompt(text: "How much memory will your apps require for all systems combined?", optionsArray: ["128 MB", "512 MB", "1 GB", "2 GB", "3 GB", "5 GB"], optionsSubtext: []))

    }
    
}
