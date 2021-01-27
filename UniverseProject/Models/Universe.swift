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

class Universe {
    var id: UUID
    private var timer: Timer?
    var age: Int = 0
    var universeRule: UniverseRule
    var contentArray: [String:Compose] = [:]
    private var readyForDestroy: [String: Galaxy] = [:]

    weak var delegate: GenerateViaDelegateProtocolGalaxy?
    
    init(id: UUID, delegate: GenerateViaDelegateProtocolGalaxy, timePeriod: Int, universeRule: UniverseRule) {
        self.id = id
        self.delegate = delegate
        self.universeRule = universeRule
        self.timer = Timer(timeInterval: 10, target: self, selector: #selector(updateTimer), userInfo: universeRule, repeats: true)
        if let timer = timer {
            RunLoop.current.add(timer, forMode: .common)
        }
    }
    
    func addComponent(component: Compose) {
        contentArray[component.id.uuidString] = component
    }
}



extension Universe: Compose{
    func countWeight() -> Int {
        return contentArray.values.reduce(0, {$0 + $1.countWeight()})
    }
    
    @objc func updateTimer(timeInterval: Int) {
        handleTimePeriod(timeInterval: 10, universeRule: self.universeRule)
    }
    
    func handleTimePeriod(timeInterval: Int, universeRule: UniverseRule)  {
        self.age += timeInterval
        print("\(timeInterval) СЕКУНД ВО ВСЕЛЕННОЙ")
        print("Общее время \(self.age)")
        
        
        if let component = delegate?.generateGalaxy(){

            contentArray[component.id.uuidString] = component
            print("СОЗДАНА НОВАЯ ГАЛАКТИКА")
        }
        if self.age % 30 == 0 && self.readyForDestroy.count >= 2  {
            print("БУДЕТ СОЗДАНА НОВАЯ ГАЛАКТИКА А ТООЧНЕЕ СЛИЯНИЕ ДВУХ ГАЛАКТИК в \(self.contentArray.keys)")
            // знайти кращий алгоритм пошуку рандомного елементу
            // TODO: think about alghorithm
            self.galaxyInteraction()
            print("СОЗДАНА НОВАЯ ГАЛАКТИКА А ТООЧНЕЕ СЛИЯНИЕ ДВУХ ГАЛАКТИК в \(self.contentArray.keys)")
        }
        
        for component in contentArray.values {
            // TODO think if logic is ok
            //TODO change galaxy age to 180
            if let galaxy = component as? Galaxy, galaxy.age >= 180, readyForDestroy[galaxy.id.uuidString] == nil {
                readyForDestroy[galaxy.id.uuidString] = galaxy
                print("ДОБАВЛЕНА ГАЛАКТИКА ДЛЯ УНИЧТОЖЕНИЯ \(galaxy.id) С ВОЗРАСТОМ \(galaxy.age)")
            }
            component.handleTimePeriod(timeInterval: timeInterval, universeRule: self.universeRule)
        }
    
        
    
       
    }
    
    
    func showContent() -> String {
        return contentArray.values.reduce(" ", { $0 + $1.showContent()})
    }
    
    func smallDescription() -> String {
        //TODO: remake this mathod
        return "Count of galaxies \(contentArray.count)"
//            contentArray.values.reduce(" ", { text, object in
//            if let galaxy = object as? Galaxy {
//                return "\(galaxy.age) \(galaxy.id)"
//            }
//            else {
//                return " "
//            }
//        })
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
        contentArray[firstGalaxy.id.uuidString] = nil
        contentArray[newGalaxy.id.uuidString] = newGalaxy
        readyForDestroy[newGalaxy.id.uuidString] = newGalaxy
        readyForDestroy[firstGalaxy.id.uuidString] = nil
        readyForDestroy[secondGalaxy.id.uuidString] = nil
        print("Galaxt interection закінчилось")
    }
    
}
