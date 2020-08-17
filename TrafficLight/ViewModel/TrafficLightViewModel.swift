//
//  TrafficLightViewModel.swift
//  TrafficLightSampleApp
//
//  Created by Nikhil on 15/08/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import Foundation
import UIKit
/*Enum for keeping the state of traffic light and return the time interval*/
enum TrafficLightState: String {
    case red
    case orange
    case green
    var timeInterval: TimeInterval {
        switch self {
        case .red: return 4
        case .orange: return 1
        case .green: return 4
        }
    }
}
/*Enum for setting the color index*/
enum TrafficLightColorIndex: Int {
      case redIndex = 0
      case orangeIndex = 1
      case greenIndex = 2
  }
/*Protocol added for notifying the state change of the traffic signal*/
protocol TrafficSignalChangeStateProtocol: class {
    func trafficSignalChangeToState(state: TrafficLightState)
}

class TrafficLightViewModel: NSObject {
    /*Variable declaration*/
    var trafficTimer: TrafficTimerUtility?
    var currentTrafficLightColor: TrafficLightState = .red
    var nextTrafficLightColor: TrafficLightState = .green
    var previousTrafficColor: TrafficLightState = .green
    weak var delegate: TrafficSignalChangeStateProtocol?
    /*Function for starting the timer based on the traffic signal state*/
    func startTrafficSignal(timerState: TrafficLightState = .red) {
        trafficTimer?.stopTrafficTimer()
        trafficTimer = TrafficTimerUtility(target: self, selector: #selector(switchTrafficLightToNextState), timerDuration: timerState.timeInterval)
        currentTrafficLightColor = timerState
    }
    /*function for switch traffic light to next state based on the next state*/
    @objc func switchTrafficLightToNextState() {
        switch currentTrafficLightColor {
        case .red:
            nextTrafficLightColor = .orange
        case .orange :
            self.setPreviuosTrafficState(trafficState: previousTrafficColor)
        case .green :
            nextTrafficLightColor = .orange
        }
        previousTrafficColor = currentTrafficLightColor
        /*calling the delegate method to update the traffic signal view in traffic light view controller*/
        delegate?.trafficSignalChangeToState(state: nextTrafficLightColor)
        /*Calling the timer function for showing next traffic signal state*/
        startTrafficSignal(timerState: nextTrafficLightColor)
    }
    func setPreviuosTrafficState(trafficState: TrafficLightState) {
        switch trafficState {
        case .red:
            nextTrafficLightColor = .green
        case .green:
            nextTrafficLightColor = .red
        case .orange:
            break
        }
    }
}
