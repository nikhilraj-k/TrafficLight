//
//  TrafficLightValidator.swift
//  TrafficLightTests
//
//  Created by Nikhil on 16/08/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import XCTest
@testable import TrafficLight
class TrafficLightValidator: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testTrafficTimerInitialTest() {
        let viewModel = TrafficLightViewModel()
        viewModel.startTrafficSignal(timerState: .green)
        XCTAssertEqual(viewModel.currentTrafficLightColor, TrafficLightState.green, "Testing the state of the traffic signal")
        XCTAssertNotEqual(TrafficLightState.red, viewModel.currentTrafficLightColor)
        viewModel.switchTrafficLightToNextState()
        XCTAssertNotEqual(TrafficLightState.green, viewModel.nextTrafficLightColor)
        XCTAssertEqual(viewModel.nextTrafficLightColor, TrafficLightState.orange, "Testing the state of the next traffic signal")
    }
    func testTimerUtilityTimer() {
        let viewModel = TrafficLightViewModel()
        viewModel.trafficTimer?.stopTrafficTimer()
        XCTAssertNil(viewModel.trafficTimer)
    }
    func testTrafficLightViewProperties() {
        let viewObject = TrafficLightView()
        viewObject.setTrafficLightInitialProperties(views: viewObject.signalViews)
        XCTAssertNotEqual(viewObject.signalViews[TrafficLightColorIndex.greenIndex.rawValue].alpha, 1.0)
        XCTAssertEqual(viewObject.signalViews[TrafficLightColorIndex.greenIndex.rawValue].alpha, 0.5)
        viewObject.setSignalViewAlpha(viewTag: TrafficLightColorIndex.orangeIndex.rawValue)
        XCTAssertEqual(viewObject.signalViews[TrafficLightColorIndex.orangeIndex.rawValue].alpha, 1.0)
        viewObject.setTrafficSignalPropertiesForState(state: TrafficLightState.red)
        XCTAssertEqual(viewObject.signalViews[TrafficLightColorIndex.orangeIndex.rawValue].alpha, 0.5)
        XCTAssertEqual(viewObject.signalViews[TrafficLightColorIndex.redIndex.rawValue].alpha, 1.0)
        XCTAssertEqual(viewObject.signalViews[TrafficLightColorIndex.greenIndex.rawValue].alpha, 0.5)
    }
    func testsetPreviuosTrafficState() {
        let viewModel = TrafficLightViewModel()
        viewModel.setPreviuosTrafficState(trafficState: .red)
        XCTAssertEqual(viewModel.nextTrafficLightColor.rawValue, TrafficLightState.green.rawValue)
        viewModel.setPreviuosTrafficState(trafficState: .green)
        XCTAssertEqual(viewModel.nextTrafficLightColor.rawValue, TrafficLightState.red.rawValue)
    }
}
