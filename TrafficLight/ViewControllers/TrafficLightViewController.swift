//
//  TrafficLightViewController.swift
//  TrafficLightSampleApp
//
//  Created by Nikhil on 15/08/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import UIKit

class TrafficLightViewController: UIViewController {
    /*Iboutlet connection for traffic view*/
    @IBOutlet var trafficLightView: TrafficLightView!
    /*Creating the object for the view model class**/
    lazy var trafficLightViewModel = {
        return TrafficLightViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setInitialProperties()
    }
    /*Function for setting the initial properties of the traffic controller*/
    func setInitialProperties() {
        trafficLightViewModel.delegate = self
        trafficLightView.delegate = self
    }
}

/*Implementing the traffic protocol methods*/
extension TrafficLightViewController: TrafficSignalChangeStateProtocol {
    func trafficSignalChangeToState(state: TrafficLightState) {
        trafficLightView.setTrafficSignalPropertiesForState(state: state)
    }
}

extension TrafficLightViewController: TrafficSignalSwitchProtocol {
    func trafficSignalSwitchChange(status: UISwitch) {
        if status.isOn {
            trafficLightView.signalViews[TrafficLightColorIndex.redIndex.rawValue].alpha = 1.0
            trafficLightViewModel.startTrafficSignal()
        } else {
            self.trafficLightViewModel.trafficTimer?.stopTrafficTimer()
            for view in trafficLightView.signalViews {
                view.alpha = 0.5
            }
        }
    }
}
