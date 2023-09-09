//
//  CoreDataFeedStore.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/8/11.
//

import CoreData

public final class CoreDataFeedStore: FeedStore {
   
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    public init(storeURL: URL, bundle: Bundle = .main) throws {
        container = try NSPersistentContainer.load(modelName: "FeedStore", url: storeURL, in: bundle)
        context = container.newBackgroundContext()
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
       
        perform { context in
            completion(Result(catching: {
                try ManagedCache.find(in: context).map {
                    CachedFeed(feed: $0.localFeed, timestamp: $0.timestamp)
                }
            }))
        }
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
        perform { context in
            completion(Result(catching: {
                let managedCache = try ManagedCache.newUniqueInstance(in: context)
                managedCache.timestamp = timestamp
                managedCache.feed = ManagedFeedImage.images(from: feed, in: context)
                
                try context.save()
            }))
        }
        
    }
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
        perform { context in
            completion(Result(catching: {
                try ManagedCache.find(in: context).map(context.delete).map(context.save)
            }))
        }
    }
    
    func perform(_ action: @escaping(NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }
    
}

