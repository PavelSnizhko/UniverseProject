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
    
    init(id: UUID, delegate: GenerateViaDelegateProtocolGalaxy?, timePeriod: Int, universeRule: UniverseRule, reloadDataDelegate: ReloadDataDelegate?) {
        self.id = id
        self.delegate = delegate
        self.universeRule = universeRule
        self.timer = Timer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: universeRule, repeats: true)
        self.reloadDelegate = reloadDataDelegate
        if let timer = timer {
            RunLoop.current.add(timer, forMode: .common)
        }
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
        //TODO: Create new queue
//        let universeQueue = DispatchQueue(label: "", qos: .default, attributes: ., autoreleaseFrequency: ., target: <#T##DispatchQueue?#>)
        handleTimePeriod(timeInterval: 10, universeRule: self.universeRule)
    }
    
    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule)  {
        self.age += timeInterval
        print("\(timeInterval) СЕКУНД ВО ВСЕЛЕННОЙ")
        print("Общее время \(self.age)")
        
        
        for component in componentsDict.values {
            // TODO think if logic is ok
            //TODO change galaxy age to 180
            if let galaxy = component as? Galaxy, galaxy.age >= 180, readyForDestroy[galaxy.id] == nil {
                readyForDestroy[galaxy.id] = galaxy
                print("ДОБАВЛЕНА ГАЛАКТИКА ДЛЯ УНИЧТОЖЕНИЯ \(galaxy.id) С ВОЗРАСТОМ \(galaxy.age)")
            }
            component.handleTimePeriod(timeInterval: timeInterval, universeRule: self.universeRule)
            
            self.reloadDelegate?.reloadData(component: nil)
        }
        
        if let component = delegate?.generateGalaxy(){

            addComponent(component: component)
            DispatchQueue.main.async { [weak self] in
                self?.reloadDelegate?.reloadData(component: component)
            }
            print("СОЗДАНА НОВАЯ ГАЛАКТИКА")
        }
        if self.age % 30 == 0 && self.readyForDestroy.count >= 2  {
            print("БУДЕТ СОЗДАНА НОВАЯ ГАЛАКТИКА А ТООЧНЕЕ СЛИЯНИЕ ДВУХ ГАЛАКТИК в \(self.componentsDict.keys)")
            // знайти кращий алгоритм пошуку рандомного елементу
            // TODO: think about alghorithm
            self.galaxyInteraction()
            print("СОЗДАНА НОВАЯ ГАЛАКТИКА А ТООЧНЕЕ СЛИЯНИЕ ДВУХ ГАЛАКТИК в \(self.componentsDict.keys)")
        }
        
        
    
        
    
       
    }
    
    
    func smallDescription() -> String {
        return "ID: \(id)"
    }
    
    func showContent() -> String {
        return "Age: \(age)   Count of galaxies: \(componentsDict.count)"
    }
}




extension Universe: Equatable {
    static func == (lhs: Universe, rhs: Universe) -> Bool {
        lhs.id == rhs.id
    }
}






private extension Universe {
    func galaxyInteraction() {
        //TODO readyForDestroy.values.randomElement() може вибрати однакові елементи змінити це
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
            print("Was add new  \(newGalaxy) and destroyed \(secondGalaxy)")
        }
        else {
            newGalaxy = secondGalaxy.interact(with: firstGalaxy)
            print("Was add new  \(newGalaxy) and destroyed \(firstGalaxy)")
        }
        componentsDict[firstGalaxy.id] = nil
        componentsDict[secondGalaxy.id] = nil
        componentsDict[newGalaxy.id] = newGalaxy
        readyForDestroy[newGalaxy.id] = newGalaxy
        readyForDestroy[firstGalaxy.id] = nil
        readyForDestroy[secondGalaxy.id] = nil
        print("Galaxt interection закінчилось")
    }
    
}
