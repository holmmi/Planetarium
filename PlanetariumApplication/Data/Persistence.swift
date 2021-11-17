//
//  Persistence.swift
//  Shared
//
//  Created by Mikael Holm on 2.11.2021.
//

import CoreData

enum ModelLoadError: Error {
    case loadFailed
}

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let favorite = Favorite(context: viewContext)
            favorite.date = ["2021-11-01", "2021-11-02", "2021-11-03", "2021-11-04", "2021-11-05"].randomElement()
            favorite.title = "All of These Space Images are Fake Except One"
            favorite.url = "https://apod.nasa.gov/apod/image/2111/AIapods01_Geach_960.jpg"
            favorite.explanation = "Why would you want to fake a universe? For one reason -- to better understand our real universe. Many astronomical projects seeking to learn properties of our universe now start with a robotic telescope taking sequential images of the night sky. Next, sophisticated computer algorithms crunch these digital images to find stars and galaxies and measure their properties."
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Main")
        
        if inMemory {
            let storeDescription = NSPersistentStoreDescription()
            storeDescription.url = URL(fileURLWithPath: "/dev/null")
            container.persistentStoreDescriptions = [storeDescription]
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    static func save(viewContext: NSManagedObjectContext) {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
