//
//  CustomTimer.swift
//  qiqi_ios
//
//  Created by design on 2018/6/20.
//  Copyright © 2018年 design. All rights reserved.
//

import UIKit

class CustomTimer: NSObject {

    typealias RunningBlock = (_ time: TimeInterval) -> ()
    
    typealias EndedBlock = () -> ()
    
    static let sharedInstand = CustomTimer()
    
    private var timer: Timer!
    ///timer begin time
    private var beginTime: TimeInterval!
    private var runBlock: RunningBlock?
    private var endedBlock: EndedBlock?
    ///timer run time
    var currentTime: TimeInterval! = 0
    ///timer run to max time change invalidate
    var maxTime: TimeInterval! = 60
    
    override init() {
        super.init()
        
    }
    
    func benginTimer(_ running: RunningBlock?) {
        self.benginTimer(running, ended: nil)
    }
    
    func benginTimer(_ running: RunningBlock?, ended: EndedBlock?) {
        self.runBlock = running
        self.endedBlock = ended
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer, forMode: RunLoop.Mode.common)
        self.currentTime = 0
        self.beginTime = Date().timeIntervalSince1970
        self.timer.fire()
    }
    
    func endTimer() {
        self.timer.fireDate = Date.distantFuture
        self.timer.invalidate()
        self.endedBlock?()
    }
    
    @objc func timerRunning() {
        let time = Date().timeIntervalSince1970
        self.currentTime = time - self.beginTime
        self.runBlock?(self.maxTime - self.currentTime)
        if self.currentTime >= self.maxTime  {
            self.endTimer()
        }
    }
}
