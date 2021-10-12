//
//  DropDownMenu.swift
//  VoiceRecorder
//
//  Created by mac on 2021/10/08.
//

import UIKit
import DropDown

func showDropDownMenu() -> DropDown {
    let dropDown = DropDown()
    
    dropDown.backgroundColor = UIColor.white
    dropDown.cornerRadius = 10
    dropDown.width = 112.5
    
    return dropDown
}
