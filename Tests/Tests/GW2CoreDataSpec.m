//
//  GW2GuildSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/7/14.
//
//

#import "GW2SharedSpec.h"
#import <Mantle/Mantle.h>
@import CoreData;

/**
 *  Creates a new in-memory persistent store for testing.
 *
 *  @param mom  The managed object model used to create the store.
 *  @return     A new in-memory persistent store.
 */
NSPersistentStoreCoordinator*
GW2SpecInMemoryStore(NSManagedObjectModel *mom) {
    return ({
        NSPersistentStoreCoordinator *psc =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
        
        [psc addPersistentStoreWithType:NSInMemoryStoreType
                          configuration:nil
                                    URL:nil
                                options:nil
                                  error:nil];

        psc;
    });
}

SpecBegin(GW2CoreData)
describe(@"core data", ^ {
    
    // Manage Object Context
    NSManagedObjectContext *__block moc;
    
    // -------------------------------------------------------------------------
    //  before
    // -------------------------------------------------------------------------
    before(^ {
        moc = [[NSManagedObjectContext alloc] init];
        expect(moc).toNot.beNil();
        
        moc.persistentStoreCoordinator = GW2SpecInMemoryStore(({
            [[NSManagedObjectModel alloc] initWithContentsOfURL:({
                GW2URLForResourceFile(@"GW2Kit", @"momd");
            })];
        }));
        
        expect(moc.persistentStoreCoordinator).toNot.beNil();
    });
    
    // -------------------------------------------------------------------------
    //
    // -------------------------------------------------------------------------
    it(@"insert object", ^ {
        id<GW2Object> object =
        [NSClassFromString(@"_GW2Object") objectWithID:@"1015"
                                                  name:@"Maguuma"
                                    fromJSONDictionary:@{}
                                                 error:nil];
        NSObject* managedObject =
        [MTLManagedObjectAdapter managedObjectFromModel:(id)object
                                   insertingIntoContext:moc
                                                  error:nil];
        
        expect([managedObject valueForKey:@"name"]).to.equal(@"Maguuma");
        expect([managedObject valueForKey:@"id"]).to.equal(@"1015");
    });
    
    // -------------------------------------------------------------------------
    //  after
    // -------------------------------------------------------------------------
    after(^ {
        moc = nil;
    });
});
SpecEnd