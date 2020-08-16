//
//  ExtensionView.swift
//  TrafficLightSampleApp
//
//  Created by Nikhil on 15/08/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import Foundation
import UIKit
/*Created the function for making the view rounded*/
extension UIView {
   func makeRounded() {
       let radius = self.frame.width/2.0
       self.layer.cornerRadius = radius
       self.layer.masksToBounds = true
       self.clipsToBounds = false
   }
}
