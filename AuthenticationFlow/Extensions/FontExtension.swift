//
//  FontExtension.swift
//  AuthenticationFlow
//
//  Created by Augray on 20/07/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI

extension Font {
    static private var Noteworthy = "Noteworthy"
    
    static var appTitleFont = Font.custom(Font.Noteworthy, size: 45)
    static var buttonFont = Font.custom(Font.Noteworthy, size: 20)
    static var signTitle = Font.custom(Font.Noteworthy, size: 30)
    static var signField = Font.custom(Font.Noteworthy, size: 20)
}

extension UIFont {
    static private var Noteworthy = "Noteworthy"
    
    static var buttonFont = UIFont(name: UIFont.Noteworthy, size: 20)
}
