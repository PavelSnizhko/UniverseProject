//
//  Galaxy.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation

enum ComparableError: Error {
    case nillException
}

class Galaxy {
    /*
    There is used contentArray because if in our galaxy will be something another than Planet system it would be useful also it's smth like open close princeple
    */
    enum GalaxyType: CaseIterable {
        case eliptical
        case irregular
        case spiral
    }
    
    var id: UUID
    private(set) var type: GalaxyType
    private(set) var age: Int = 0
    private(set) var weight: Int = 0
    private(set) var contentArray: [String:Compose] = [:]
    private weak var delegate: GenerateViaDelegateProtocolPlanetarySystem?
    private weak var appendBlackHole: GenerateViaDelegateProtocolBlackHole?
    
    
    init(id: UUID, type: GalaxyType, age: Int = 0, delegate: GenerateViaDelegateProtocolPlanetarySystem?) {
        self.id = id
        self.type = type
        self.age = age
        self.delegate = delegate
    }
    
    init(id: UUID, type: GalaxyType, age: Int = 0, delegate: GenerateViaDelegateProtocolPlanetarySystem?, contentArray: [String:Compose]) {
        self.id = id
        self.type = type
        self.age = age
        self.delegate = delegate
        self.contentArray = contentArray
    }
    
    func increaseWeight(weight: Int) {
        self.weight += weight
    }
    
    
    func addComponent(component: Compose) {
        contentArray[component.id.uuidString] = component
    }
    
    
    func increaeAge(age: Int = 10) {
        self.age += age
    }
    
    func interact(with galaxy: Galaxy) -> Galaxy {
        //TODO: Можливо потрібно використовувати фабрику ?
        //TODO return self is it ok?
        //TODO потерей 10% звездно-планетарных систем з обох галактик
        print("\(self.contentArray) dictionary before")
        print("\(self.contentArray.count) + Before ")
        print("\(self.id.uuidString) И \(galaxy.id.uuidString)")
        
        var newDict = self.contentArray.reduce(into: galaxy.contentArray) { (r, e) in r[e.0] = e.1 }
        print("\(newDict.count) + after ")
        let numberElemetsForDestroying = Int(Double(newDict.count) * 0.1)
        for _ in 0..<numberElemetsForDestroying {
            if let id = newDict.keys.randomElement() {
                //TODO if it's work well show alert if it deleted...?
                
               let planetarySystem = newDict.removeValue(forKey: id)
                print("\(String(describing: planetarySystem?.id)) ВИДАЛЕНА")
            }
        
        }
        print(" После Изминениц dictionary \(newDict) ")
        //TODO change using fabric or smth else
        let galaxy = Galaxy(id: UUID(), type: self.type, age: self.age, delegate: self.delegate, contentArray: newDict)
        galaxy.delegate = self.delegate
        return galaxy
    }

}


extension Galaxy: Comparable, Compose {
    func countWeight() -> Int {
        self.weight = contentArray.values.reduce(0, {$0 + $1.countWeight()})
        return self.weight
    }
    

    
    
    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule) {
        self.age += timeInterval
        
        if let planetarySystem = delegate?.generatePlanetarySystem(galaxyDelegat: self){
            contentArray[planetarySystem.id.uuidString] = planetarySystem
            print("Створа нова планетарна система \(planetarySystem.id.uuidString)")
            print("Загальна кількість планетарних систем  \(contentArray)")
        }
        for item in contentArray.values {
            item.handleTimePeriod(timeInterval: timeInterval, universeRule: universeRule)
        }
        
    }
    
    static func < (lhs: Galaxy, rhs: Galaxy) -> Bool {
        return lhs.weight < lhs.weight
    }
    
    static func == (lhs: Galaxy, rhs: Galaxy) -> Bool {
        lhs.weight == rhs.weight
    }
    
    func showContent() -> String {
        return contentArray.values.reduce("", { $0 + $1.showContent()})
    }
    
    func smallDescription() -> String {
//    TODO:  smallDescription()  call from star and update collection view 
        return "\(age)" + "\(id)" + "\(type)" + contentArray.reduce(" ", { text, object in
            if let star = object as? Star {
                return text + star.id.uuidString
            }
            else {
                return " "
            }
        })
    }
}


extension Galaxy: DestroyPlanetarySystem {
    func destroyPlanetarySystem(id: String, blackHole: BlackHole) {
        self.contentArray[id] = blackHole
    }
    
    
}
