//
//  String.swift
//  Multitimer
//
//  Created by Милена on 06.07.2021.
//

import Foundation

extension String {
    struct Error {
        static let error = "Ошибка"
        static let ok = "Ок"
        static let fillAllFields = "Заполните все поля"
        static let wrongTime = "Недопустимое значение для таймера"
        static let initNotImplemented = "init(coder:) has not been implemented"
    }
    
    static let timerName = "Название таймера"
    static let timeOfSeconds = "Время в секундах"
    static let add = "Добавить"
    static let multiTimer = "Мульти таймер"
}
