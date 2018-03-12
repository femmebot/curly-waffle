//
//  Prompt.swift
//  cg-estimator
//
//  Created by Phoebe Espiritu on 3/12/18.
//  Copyright © 2018 Phoebe Espiritu. All rights reserved.
//

import Foundation

class Prompt {
    let promptText : String
    let choicesArray : Array<Any>
    let choicesSubtext : Array<String>?
    
    init(text : String, optionsArray : Array<Any>, optionsSubtext : Array<String>) {
        promptText = text
        choicesArray = optionsArray
        choicesSubtext = optionsSubtext
    }
}
