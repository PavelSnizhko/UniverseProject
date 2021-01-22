//
//  GenerateViaDelegateProtocol.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation

typealias PowerModelGenerator = GenerateViaDelegateProtocolGalaxy & GenerateViaDelegateProtocolPlanet & GenerateViaDelegateProtocolStar


protocol GenerateViaDelegateProtocolGalaxy: class {
    func generateGalaxy() -> Galaxy
}


protocol GenerateViaDelegateProtocolStar: class {
    func generateStar() -> Star
}




protocol GenerateViaDelegateProtocolPlanet: class {
    func generatePlanet() -> Planet
}



extension GenerateViaDelegateProtocolStar {
    func generateStar() -> Star {
        let type = Star.StarType.allCases.randomElement()!
        return Star(name: "New Star", weight: Int.random(in: 0..<100), type: type, temeperature: Int.random(in: 0..<100), luminosity: Int.random(in: 0..<100), radius: Int.random(in: 0..<100))
    }
}

extension GenerateViaDelegateProtocolPlanet {
    func generatePlanet() -> Planet {
        let type = Planet.PlanetType.allCases.randomElement()!
        return Planet(name: "New Planet + \(type)", weight: Int.random(in: 0..<100), satelliteArray: [], type: type)
    }
}


extension GenerateViaDelegateProtocolGalaxy {
    func generateGalaxy() -> Galaxy {
        print("Was created new Galaxy")
        let type = Galaxy.GalaxyType.allCases.randomElement()!
        return Galaxy(name: "New Galaxy + \(type)", type: type)
    }
}


