//
//  BlackHole.swift
//  UniverseProject
//
//  Created by Павел Снижко on 09.02.2021.
//

import Foundation


class BlackHole: Compose {
    private(set) var id: UUID
    private(set) var age: Int = 0
    let radius: Int
    let weight: Int
    weak var reloadDelegate: ReloadDataDelegate?
    private(set) var componentsDict: [UUID : Compose] = [:]

    
    init(id: UUID, weight: Int, radius: Int) {
        self.id = id
        self.weight = weight
        self.radius = radius
        print(".............BlackHole is created..................................")
    }
    
    deinit {
        print("...........||| BlackHole is delete |||..................................")

    }
    
    
    func countWeight() -> Int {
        self.weight
    }
    
    func smallDescription() -> [String: String] {
        return ["id": id.uuidString]
    }
    
    func showContent() -> [String: String] {
        return ["weight": String(countWeight()), "radius": String(radius), "age": String(age) ]
    }
    
    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule) {
        self.age += timeInterval
        print("Добавився час в Чорній дирі")
    }
    
   
}
