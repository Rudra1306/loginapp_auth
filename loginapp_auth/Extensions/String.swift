//
//  String.swift
//  loginapp_auth
//
//  Created by Rudra on 16/07/23.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        
        let regex = try! NSRegularExpression(pattern:
                                                "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        
        return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil

        
    }
    
}
