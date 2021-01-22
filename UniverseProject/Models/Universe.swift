//
//  Universe.swift
//  UniverseProject
//
//  Created by Павел Снижко on 21.01.2021.
//

import Foundation

class Universe {
    var id: UInt32 = arc4random_uniform(100)
    var name: String
    let timer = Timer()
    var age: Int = 0
    
    var contentArray = [Compose]()
    //make like a set
    private var readyForDestroy = [Compose]()

    weak var delegate: GenerateViaDelegateProtocolGalaxy?
    
    init(name: String) {
        self.name = name
    }
    
    func addComponent(component: Compose) {
        contentArray.append(component)
    }
}

extension Universe: Compose {
    func handleTimePeriod(timeInterval: Int)  {
        self.age += timeInterval
//        for item in contentArray {
//            // TODO think if logic is ok
//            if let galaxy = item as? Galaxy, galaxy.age >= 30{
//                readyForDestroy.append(galaxy)
//            }
//            item.handleTimePeriod(timeInterval: timeInterval)
//        }
        self.contentArray.append(delegate?.generateGalaxy() as! Compose)
        if self.age != 0 && self.age % 30 == 0 {
            // знайти кращий алгоритм пошуку рандомного елементу
            guard let galaxy1 = readyForDestroy.randomElement() as? Galaxy, let galaxy2 = readyForDestroy.randomElement() as? Galaxy else  { return }
            
            if galaxy1 >= galaxy2 {
                let newGalaxy = galaxy1.interact(with: galaxy2)
                contentArray.append(newGalaxy)
                readyForDestroy.append(newGalaxy)
                print("Was add new  \(newGalaxy) and destroyed \(galaxy2)")
            }
            else {
                let newGalaxy = galaxy2.interact(with: galaxy1)
                contentArray.append(newGalaxy)
                print("Was add new  \(newGalaxy) and destroyed \(galaxy1)")
            }
        }
       
    }
    
    func showContent() -> String {
        return contentArray.reduce(" ", { $0 + $1.showContent()})
    }
    
    func smallDescription() -> String {
        // TODO: можливо weak self ?
        return name + contentArray.reduce(" ", { text, object in
            if let galaxy = object as? Galaxy {
                return text + galaxy.name
            }
            else {
                return " "
            }
        })
    }
}
