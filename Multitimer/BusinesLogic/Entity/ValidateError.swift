//
//  SystemError.swift
//  Multitimer
//
//  Created by Милена on 06.07.2021.
//

import Foundation

enum ValidateError: LocalizedError {
    case emptyFields
    case wrongTime
  
    var errorDescription: String? {
        switch self {
        case .emptyFields:
            return String.Error.fillAllFields
        case .wrongTime:
            return String.Error.wrongTime
        }
    }
}            
