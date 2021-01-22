//
//  Planet.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation

class Planet {
    enum PlanetType: String, CaseIterable {
        case iron = "Iron type of planet"
        case silicate = "Silicate type of planet "
        case carbon = " Carbon type of planet "
    }
    
    weak var delegate: GenerateViaDelegateProtocolPlanet? {
        get {
            self.delegate
        }
        set {
            self.delegate = newValue
        }
    }
    
    var id = arc4random_uniform(100)
    private var name: String
    private var type: PlanetType
    private var weight: Int
    var satelliteArray: [Planet] = []
    
    //массив для супутников
    private var statelArray: [Compose] = []
    
    init(name: String, weight: Int, satelliteArray: [Planet], type: PlanetType) {
        //можливо винести вибір рандомного супутника окремо
        self.name = name
        self.weight = weight
//        self.satelliteArray = satelliteArray
        self.type = type
//        self.delegate = delegate
    }
    
   

}

extension Planet: Compose {
    func handleTimePeriod(timeInterval: Int) {
        return
    }
    
    func showContent() -> String {
        return name
    }
    
    func smallDescription() -> String {
        return name
    }
    
}
