//
//  Universe.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation

struct UniverseRule {
   let radiusBoundary: Int
   let weightBoundary: Int
    
}

class Universe: Compose {
    var reloadDelegate: ReloadDataDelegate?
    private (set) var id: UUID
    private var timer: Timer?
    private (set) var age: Int = 0
    private var universeRule: UniverseRule
    private (set) var componentsDict: [UUID:Compose] = [:]
    private var readyForDestroy: [UUID:Galaxy] = [:]
    private weak var delegate: GenerateViaDelegateProtocolGalaxy?
    weak var deleteComponentsDelegate: DeleteComponentsDelegate?
    
    init(id: UUID, delegate: GenerateViaDelegateProtocolGalaxy?, timePeriod: Int, universeRule: UniverseRule, reloadDataDelegate: ReloadDataDelegate?) {
        self.id = id
        self.delegate = delegate
        self.universeRule = universeRule
        self.timer = Timer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: universeRule, repeats: true)
        self.reloadDelegate = reloadDataDelegate
        if let timer = timer {
            RunLoop.current.add(timer, forMode: .common)
        }
        print("Universe is created")
    }
    
    func addComponent(component: Compose) {
        componentsDict[component.id] = component
    }
}



extension Universe{

    
    func countWeight() -> Int {
        return componentsDict.values.reduce(0, {$0 + $1.countWeight()})
    }
    
    @objc func updateTimer(timeInterval: Int) {
        handleTimePeriod(timeInterval: 10, universeRule: self.universeRule)
    }
    
    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule)  {
        self.age += timeInterval
//        print("\(timeInterval) СЕКУНД ВО ВСЕЛЕННОЙ")
                
        for component in componentsDict.values {
            if let galaxy = component as? Galaxy, galaxy.age >= 180, readyForDestroy[galaxy.id] == nil {
                readyForDestroy[galaxy.id] = galaxy
            }
            component.handleTimePeriod(timeInterval: timeInterval, universeRule: self.universeRule)
        }
        
        if let component = delegate?.generateGalaxy(){

            addComponent(component: component)
            self.reloadDelegate?.reloadData(component: component)
            print("СОЗДАНА НОВАЯ ГАЛАКТИКА")
        }
        
        if self.age % 30 == 0 && self.readyForDestroy.count >= 2  {
            self.galaxyInteraction()
        }

    }
    
    
    func smallDescription() -> [String: String] {
        return ["id": id.uuidString]
    }
    
    func showContent() -> [String: String] {
        return ["age" : String(self.age),
                "weight": String(countWeight()),
                "count of galaxies": String(componentsDict.count)]
    }
}




extension Universe: Equatable {
    static func == (lhs: Universe, rhs: Universe) -> Bool {
        lhs.id == rhs.id
    }
}



private extension Universe {
    
    // Todo Move to another class it's not approoriate to be here
    func galaxyInteraction() {
        var firstGalaxy: Galaxy
        var secondGalaxy: Galaxy
        repeat {
            guard let galaxy1 = readyForDestroy.values.randomElement(), let galaxy2 = readyForDestroy.values.randomElement() else  { return }
            firstGalaxy = galaxy1
            secondGalaxy = galaxy2
        } while firstGalaxy.id == secondGalaxy.id
        
        var newGalaxy: Galaxy
        if firstGalaxy >= secondGalaxy {
            newGalaxy = firstGalaxy.interact(with: secondGalaxy)
        }
        else {
            newGalaxy = secondGalaxy.interact(with: firstGalaxy)
        }
        
        self.deleteComponentsDelegate?.deleteComponents(from: self, components: (componentsDict.removeValue(forKey: firstGalaxy.id)!, componentsDict.removeValue(forKey: secondGalaxy.id)!))
        
        componentsDict[newGalaxy.id] = newGalaxy
        readyForDestroy[newGalaxy.id] = newGalaxy
        self.reloadDelegate?.reloadData(component: newGalaxy)
        readyForDestroy[firstGalaxy.id] = nil
        readyForDestroy[secondGalaxy.id] = nil
    }
}
