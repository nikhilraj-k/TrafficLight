//
//  TrafficLightView.swift
//  TrafficLightSampleApp
//
//  Created by Nikhil on 15/08/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import UIKit

/*Protocol added for notifying the state change of the traffic signal*/
protocol TrafficSignalSwitchProtocol: class {
    func trafficSignalSwitchChange(status: UISwitch)
}

class TrafficLightView: UIView {
    @IBOutlet var signalViews: [UIView]!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var startSignalLabel: UILabel!
    @IBOutlet weak var onOffSignalSwitch: UISwitch!
    weak var delegate: TrafficSignalSwitchProtocol?

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
        Bundle.main.loadNibNamed(trafficLightView, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.setTrafficLightInitialProperties(views: self.signalViews)
        self.headerLabel.text = trafficHeaderLabel
        self.onOffSignalSwitch.setOn(false, animated: false)
        startSignalLabel.text = startSignal
    }
    // MARK: Instance functions
    /*Function for setting the initial state of the traffic light*/
    func setTrafficLightInitialProperties(views: [UIView]) {
        for view in views {
            view.makeRounded()
            view.alpha = 0.5
            switch view.tag {
            case 0:
                view.backgroundColor = .red
            case 1:
                view.backgroundColor = .orange
            case 2:
                view.backgroundColor = .green
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
    @IBAction func onOffSignalSwitchAction(_ sender: UISwitch) {
        delegate?.trafficSignalSwitchChange(status: sender)
    }
}
