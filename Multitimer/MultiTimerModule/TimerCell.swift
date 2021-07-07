//
//  TimerCell.swift
//  Multitimer
//
//  Created by Милена on 06.07.2021.
//

import UIKit
import SnapKit

class TimerCell: UITableViewCell {
    var timerNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    var pauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        return button
    }()
    
    var timer: MyTimer?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError(String.Error.initNotImplemented)
    }

    private func layoutViews() {
        contentView.addSubview(timerNameLabel)
        timerNameLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(25)
            make.centerY.equalTo(contentView)
        }
        
        contentView.addSubview(pauseButton)
        pauseButton.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
        pauseButton.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).inset(20)
            make.centerY.equalTo(contentView)
            let size = contentView.bounds.height 
            make.height.width.equalTo(size)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.right.equalTo(pauseButton).inset(45)
            make.centerY.equalTo(contentView)
            make.left.greaterThanOrEqualTo(timerNameLabel.snp.right).offset(16)
        }
        
        let priority = UILayoutPriority(740)
        timerNameLabel.setContentCompressionResistancePriority(priority, for: .horizontal)
    }
    

    @objc func pauseTimer(sender: UIButton!) {
        if timer?.suspended == false {
            timer?.suspended = true
            pauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        } else {
            timer?.suspended = false
            pauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        }
    }
      
    func fill(timer: MyTimer) {
        self.timer = timer
        timerNameLabel.text = timer.nameTimer
        displayTime(timer.time)
    }
    
    func displayTime(_ time: Int) {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        let formattedString = formatter.string(from: TimeInterval(time))
        timeLabel.text = formattedString
    }
}
