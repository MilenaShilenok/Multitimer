//
//  Timer.swift
//  Multitimer
//
//  Created by Милена on 06.07.2021.
//

import Foundation

class MyTimer {
    var nameTimer = ""
    var time = 0
    var suspended = false
    
    init(nameTimer: String, time: Int) {
        self.nameTimer = nameTimer
        self.time = time
    }
    
    func apdateTime() {
        if !suspended {
            time -= 1
        }
    }
}
