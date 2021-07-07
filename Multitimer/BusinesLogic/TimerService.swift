//
//  TimersBank.swift
//  Multitimer
//
//  Created by Милена on 06.07.2021.
//

import Foundation

class TimerService {
    static let instance = TimerService()
    private init() {}
    
    var timers: [MyTimer] = []
    
    func add(timer: MyTimer) {
        timers.append(timer)
        sort()
    }

    func apdateTime() {
        var index = 0
        while index < timers.count {
            timers[index].apdateTime()
            
            if timers[index].time <= 0 {
                removeTimer(index: index)
            }
            index += 1
        }
    }
    
    func sort() {
        let timersSort = timers.sorted(by: { $0.time > $1.time })
        timers = timersSort
    }
    
    func removeTimer(index: Int) {
        timers.remove(at: index)
    }
}
