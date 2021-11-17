//
//  FavoriteRepository.swift
//  Planetarium (iOS)
//
//  Created by Mikael Holm on 15.11.2021.
//

import Foundation
import CoreData

struct FavoriteRepository {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func getFavorites() -> [Favorite] {
        let favoritesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        let sort = NSSortDescriptor(key: "date", ascending: false)
        favoritesFetch.sortDescriptors = [sort]
        do {
            return try context.fetch(favoritesFetch) as! [Favorite]
        } catch {
            fatalError("Failed to fetch favorites: \(error)")
        }
    }
    
    func addFavorite(pictureInfo: PictureInfo) {
        let favorite = Favorite(context: context)
        favorite.explanation = pictureInfo.explanation
        favorite.thumbnailUrl = pictureInfo.thumbnailUrl
        favorite.title = pictureInfo.title
        favorite.url = pictureInfo.url
        favorite.date = pictureInfo.date
        favorite.video = pictureInfo.mediaType == "video"
        PersistenceController.save(viewContext: context)
    }
    
    func deleteFavorite(favorite: Favorite) {
        context.delete(favorite)
        PersistenceController.save(viewContext: context)
    }
    
    func favoriteExists(date: String) -> Bool {
        let favoritesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        favoritesFetch.predicate = NSPredicate(format: "date == %@", date)
        do {
            return try context.count(for: favoritesFetch) > 0
        } catch {
            fatalError("Failed to fetch favorites: \(error)")
        }
    }
}
