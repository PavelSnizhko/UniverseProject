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
    
    private(set) var id: UUID
    private(set) var type: GalaxyType
    private(set) var age: Int = 0
    private(set) var weight: Int = 0
    private(set) var componentsDict: [UUID:Compose] = [:] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadDelegate?.reloadData(component: nil)

            }
        }
    }
    private weak var delegate: GenerateViaDelegateProtocolPlanetarySystem?
    private weak var appendBlackHole: GenerateViaDelegateProtocolBlackHole?
    weak var deleteDelegate: DeleteDataDelegate?
    weak var reloadDelegate: ReloadDataDelegate?
    
 
    
    
    init(id: UUID, type: GalaxyType, age: Int = 0, delegate: GenerateViaDelegateProtocolPlanetarySystem?) {
        self.id = id
        self.type = type
        self.age = age
        self.delegate = delegate
    }
    
    init(id: UUID, type: GalaxyType, age: Int = 0, delegate: GenerateViaDelegateProtocolPlanetarySystem?, contentArray: [UUID:Compose]) {
        self.id = id
        self.type = type
        self.age = age
        self.delegate = delegate
        self.componentsDict = contentArray
    }
    
    
    func increaseWeight(weight: Int) {
        self.weight += weight
    }
    
    
    func addComponent(component: Compose) {
        componentsDict[component.id] = component
    }
    
    
    func increaeAge(age: Int = 10) {
        self.age += age
    }
    
    func interact(with galaxy: Galaxy) -> Galaxy {
        var newDict = self.componentsDict.reduce(into: galaxy.componentsDict) { (r, e) in r[e.0] = e.1 }

        //TODO: separet this logic
        let numberElemetsForDestroying = Int(Double(newDict.count) * 0.1)
        for _ in 0..<numberElemetsForDestroying {
            if let id = newDict.keys.randomElement() {
                //TODO if it's work well show alert if it deleted...?
                    
                if let planetarySystem = newDict.removeValue(forKey: id) {
                    
                    self.deleteDelegate?.deleteData(deletedComponent: planetarySystem)
//                    print("\(String(describing: planetarySystem.id)) ВИДАЛЕНА ")
                }
            }
        
        }
        //TODO change using fabric or smth else
        let galaxy = Galaxy(id: UUID(), type: self.type, age: self.age, delegate: self.delegate, contentArray: newDict)
        galaxy.delegate = self.delegate
        return galaxy
    }
    
    deinit {
        print("----------Галактика \(id) видалена---------------")
    }

}


extension Galaxy: Comparable, Compose {
    
    func countWeight() -> Int {
        self.weight = componentsDict.values.reduce(0, {$0 + $1.countWeight()})
        return self.weight
    }
    
    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule) {
        self.age += timeInterval
        
        for item in componentsDict.values {
            item.handleTimePeriod(timeInterval: timeInterval, universeRule: universeRule)
        }
        
        if let planetarySystem = delegate?.generatePlanetarySystem(galaxyDelegat: self) {
            componentsDict[planetarySystem.id] = planetarySystem
            DispatchQueue.main.async { [weak self] in
                self?.reloadDelegate?.reloadData(component: planetarySystem)
            }
//            print("Planetary system \(planetarySystem.id) is added ")
        }
        self.reloadDelegate?.reloadData(component: nil)
        
    }
    
    static func < (lhs: Galaxy, rhs: Galaxy) -> Bool {
        return lhs.weight < lhs.weight
    }
    
    static func == (lhs: Galaxy, rhs: Galaxy) -> Bool {
        lhs.weight == rhs.weight
    }
    
    
    func showContent() -> String {
        return "Age: \(age)" + "\t Type: \(type)" + " \t Count of Planetary System \(componentsDict.count)"
    }
    
    func smallDescription() -> String {
        return " \(self.id) "
    }
}


extension Galaxy: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


//TODO Викликати знищення галактики якщо зіткнення



extension Galaxy: DestroyPlanetarySystem {
    // To have posibility in future acces by id to black hole I should not save under planetary system id but under blackHol's
    func destroyPlanetarySystem(id: UUID, blackHole: BlackHole) {
        print("Зараз буде знищення цілої планетної системи в Галактиці \(self.componentsDict.values)")
        self.componentsDict[blackHole.id] = blackHole
        self.componentsDict.removeValue(forKey: id)
        self.deleteDelegate?.deleteData(deletedComponent: self)
        print( "Має відкинути назад якщо у галактиці \(self.id)")
        print("Відбулося знищення цілої планетної системи в Галактиці \(self.componentsDict.values)")

    }
    
    
}
