//
//  PlanetAppTests.swift
//  PlanetAppTests
//
//
//

import XCTest
@testable import PlanetAssessment

class PlanetAssessmentTests: XCTestCase {

    var viewModel: ViewModel!
    
    override func setUp() {
        viewModel = ViewModel() 
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func testNewPlanetName() {
        let planet = Planet(name: "Igweplanet", moons: 1)
        XCTAssert(planet.name == "Igweplanet", "Planet is not called 'Igweplanet'")
    }
    
    func testNewPlanetMoon() {
        let planet = Planet(name: "Igweplanet", moons: 1)
        XCTAssert(planet.moons == 1, "Planet does not have 1 moon")
    }
    
    func testPlanetList(){
        let planets = viewModel.planets.count
        XCTAssert(planets == 0, "View Model doesn't allow 0 planets")
    }

}
