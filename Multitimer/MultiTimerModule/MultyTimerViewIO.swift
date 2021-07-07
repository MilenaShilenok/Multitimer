//
//  MultyTimerViewIO.swift
//  Multitimer
//
//  Created by Милена on 06.07.2021.
//

import Foundation

protocol MultiTimerViewInput: class {
    func show(error: Error)
    func reloadTableView()
    func insertNewTimer()
}

protocol MultiTimerViewOutput {
    var timers: [MyTimer] { get }
    
    func add(nameTimer: String, time: String)
    func apdateTimers()
}
