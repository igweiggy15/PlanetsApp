//
//  CoreManager.swift
//  PlanetApp
//
//
//
//
//CoreManager

import CoreData

final class CoreManager {
    
    static let shared = CoreManager()
    
    private init(){}
    
        var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PlanetAssessment")
        
        container.loadPersistentStores {
            (storeDescrip, err) in
            if let error = err{
                fatalError(error.localizedDescription)
            }
        }
        return container
        
    }()
    
    //MARK: Load
    func load() -> [Planet] {
        let fetch = NSFetchRequest<PlanetEntity>(entityName: "PlanetEntity")
        
        var planets = [Planet]()
        
        planets.append(Planet(name: "Earth", moons: 1))
        planets.append(Planet(name: "Mars", moons: 2))
        planets.append(Planet(name: "Jupiter", moons: 67))
        planets.append(Planet(name: "Venus", moons: 0))
        planets.append(Planet(name: "Uranus", moons: 27))
        planets.append(Planet(name: "Saturn", moons: 82))
        planets.append(Planet(name: "Neptune", moons: 13))
        planets.append(Planet(name: "Mercury", moons: 0))
        
        do {
            let corePlanets = try context.fetch(fetch)
            
            for core in corePlanets{
                let planet = Planet(name: core.name!, moons: Int(core.moons))
                planets.append(planet)
            }
            
        } catch {
            print("Couldn't fetch planets: \(error.localizedDescription)")
        }
        
        planets = planets.filter{$0.moons < 3}
        
        return planets
        
    }
    
    //MARK: Save
    func save(_ planet: Planet){
        guard let entity = NSEntityDescription.entity(forEntityName: "PlanetEntity", in: context) else {return}
        
        let corePlanet = PlanetEntity(entity: entity, insertInto: context)
        
        corePlanet.name = planet.name
        corePlanet.moons = Int64(planet.moons)
        
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
