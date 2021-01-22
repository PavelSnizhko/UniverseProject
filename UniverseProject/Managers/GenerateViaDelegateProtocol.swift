//
//  GenerateViaDelegateProtocol.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation

typealias PowerModelGenerator = GenerateViaDelegateProtocolGalaxy & GenerateViaDelegateProtocolPlanet & GenerateViaDelegateProtocolStar


protocol GenerateViaDelegateProtocolGalaxy: class {
    func generateGalaxy() -> Compose
}


protocol GenerateViaDelegateProtocolStar: class {
    func generateStar() -> Compose
}




protocol GenerateViaDelegateProtocolPlanet: class {
    func generatePlanet() -> Compose
}






