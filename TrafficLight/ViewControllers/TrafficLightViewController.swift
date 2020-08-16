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
        trafficLightViewModel.startTrafficSignal()
    }
}

/*Implementing the traffic protocol methods*/
extension TrafficLightViewController: TrafficSignalChangeStateProtocol {
    func trafficSignalChangeToState(state: TrafficLightState) {
        trafficLightView.setTrafficSignalPropertiesForState(state: state)
    }
}
