//
//  MultiTimerPresenter.swift
//  Multitimer
//
//  Created by Милена on 06.07.2021.
//

import Foundation

class MultiTimerPresenter: MultiTimerViewOutput {
    weak var view: MultiTimerViewInput!
    private let service = TimerService.instance
    
    init (view: MultiTimerViewInput) {
        self.view = view
    }
    
    var timer: Timer?
    
    var timers: [MyTimer] {
        return service.timers
    }
    
    private func validate(nameTimer: String, time: String) throws {
        if nameTimer == "" || time == "" {
            throw ValidateError.emptyFields
        }
        guard let _ = Int(time) else {
            throw ValidateError.wrongTime
        }
    }
    
    func add(nameTimer: String, time: String) {
        do {
            try validate(nameTimer: nameTimer, time: time)
            let timer = MyTimer(nameTimer: nameTimer, time: Int(time) ?? 0)
            service.add(timer: timer)
            view.insertNewTimer()
        } catch {
            view.show(error: error)
        }
        
        if timers.count == 1 {
            startTimer()
        }
    }
    
    private func startTimer() {
        DispatchQueue.global(qos: .background).async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector: #selector(self.apdateTimers),
                                              userInfo: nil,
                                              repeats: true)
            let runLoop = RunLoop.current
            guard let timer = self.timer else {
                return
            }
            runLoop.add(timer, forMode: .default)
            runLoop.run()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc func apdateTimers() {
        DispatchQueue.main.async {
            self.service.apdateTime()

            if self.timers.count == 0 {
                self.stopTimer()
            }
            
            self.view.reloadTableView()
        }
    }
}
