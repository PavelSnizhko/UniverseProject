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
    
    weak var delegate: GenerateViaDelegateProtocolSatellite?
    
    var id: UUID
    private(set) var type: PlanetType
    private(set) var weight: Int
    private(set) var age: Int = 0
    private(set) var componentsDict: [UUID : Compose] = [:]
    weak var reloadDelegate: ReloadDataDelegate?

    
    //массив для супутников
    private var statelArray: [Compose] = []
    
    init(weight: Int, satelliteArray: [UUID:Compose], type: PlanetType, delegate: GenerateViaDelegateProtocolSatellite?, id: UUID) {
        self.id = id
        self.weight = weight
        self.componentsDict = satelliteArray
        self.type = type
        self.delegate = delegate
//        self.delegate = delegate
    }
    
    
    deinit {
        print("Планета \(id) видалена")
    }
   

}

extension Planet: Compose {
    
    func countWeight() -> Int {
        return componentsDict.values.reduce(0, { $0 + $1.countWeight() } )
    }
    

    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule) {
        self.age += timeInterval
        print("Планета \(id.uuidString) прожила \(self.age)")
    }
    
    func showContent() -> String {
        //TODO create prety show content
        return id.uuidString + type.rawValue
    }
    
    func smallDescription() -> String {
        return id.uuidString + type.rawValue
    }
    
    
}
