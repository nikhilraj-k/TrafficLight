//
//  TrafficLightView.swift
//  TrafficLightSampleApp
//
//  Created by Nikhil on 15/08/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import UIKit

class TrafficLightView: UIView {
    @IBOutlet var signalViews: [UIView]!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    /*
     @IBOutlet var contentView: UIView!
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit() {
        Bundle.main.loadNibNamed("TrafficLightView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.setTrafficLightInitialProperties(views: self.signalViews)
        self.headerLabel.text = trafficHeaderLabel
    }
    // MARK: Instance functions
    /*Function for setting the initial state of the traffic light*/
    func setTrafficLightInitialProperties(views: [UIView]) {
        for view in views {
            view.makeRounded()
            switch view.tag {
            case 0:
                view.backgroundColor = .red
            case 1:
                view.backgroundColor = .orange
                view.alpha = 0.5
            case 2:
                view.backgroundColor = .green
                view.alpha = 0.5
            default:
                print("")
            }
        }
    }
    /*Function for changing the signal view alpha*/
    func setSignalViewAlpha(viewTag: Int) {
        for view in signalViews {
            if view.tag == viewTag {
                view.alpha = 1.0
            } else {
                view.alpha = 0.5
            }
        }
    }
    /*Function for setting the traffic light based on the state*/
    func setTrafficSignalPropertiesForState(state: TrafficLightState) {
        switch state {
        case .red:
            setSignalViewAlpha(viewTag: TrafficLightColorIndex.redIndex.rawValue)
        case .orange :
            setSignalViewAlpha(viewTag: TrafficLightColorIndex.orangeIndex.rawValue)
        case .green :
            setSignalViewAlpha(viewTag: TrafficLightColorIndex.greenIndex.rawValue)
        }
    }
}
