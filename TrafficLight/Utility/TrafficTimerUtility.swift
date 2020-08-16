//
//  TrafficTimerUtility.swift
//  TrafficLightSampleApp
//
//  Created by Nikhil on 13/08/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import Foundation
class TrafficTimerUtility: NSObject {
    var trafficTarget: NSObject!
    var trafficSelector: Selector!
    var trafficTimer: Timer?
    /*Traffic light timer init method*/
    init(target: NSObject, selector: Selector, timerDuration: TimeInterval) {
        super.init()
        self.trafficTarget = target
        self.trafficSelector = selector
        self.trafficTimer = Timer.scheduledTimer(timeInterval: timerDuration, target: self, selector: #selector(trafficLightAction), userInfo: nil, repeats: false)
    }
    /*Function for stopping the timer*/
    func stopTrafficTimer() {
        guard self.trafficTimer != nil else {
            return
        }
        self.trafficTimer?.invalidate()
        trafficTimer = nil
        self.trafficTarget = nil
        self.trafficSelector = nil
    }
    /*Timer action*/
    @objc func trafficLightAction() {
        self.trafficTarget.perform(self.trafficSelector)
    }
}
