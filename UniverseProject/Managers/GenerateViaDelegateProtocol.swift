//
//  GenerateViaDelegateProtocol.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation

typealias PowerModelGenerator = GenerateViaDelegateProtocolGalaxy & GenerateViaDelegateProtocolPlanet & GenerateViaDelegateProtocolPlanetarySystem & GenerateViaDelegateProtocolSatellite & GenerateViaDelegateProtocolBlackHole


protocol GenerateViaDelegateProtocolGalaxy: class {
    func generateGalaxy() -> Compose
}


protocol GenerateViaDelegateProtocolPlanetarySystem: class {
    func generatePlanetarySystem(galaxyDelegat: Galaxy) -> Compose
}


protocol GenerateViaDelegateProtocolPlanet: class {
    func generatePlanet() -> Compose
}

protocol GenerateViaDelegateProtocolSatellite: class {
    func generateStatelite() -> [UUID: Compose]
}

protocol GenerateViaDelegateProtocolBlackHole: class {
    func generateBlackHole(star: Star) -> BlackHole
}






