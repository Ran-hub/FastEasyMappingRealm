// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

#import "FEMObjectCache+Realm.h"

@import FastEasyMapping.FEMMapping;

@import Realm.RLMRealm;
@import Realm.RLMResults;
@import Realm.RLMObjectBase;
@import Realm.Dynamic;

BOOL FEMMappingRequiresPrefetch(FEMMapping *mapping) {
    if (mapping.primaryKeyAttribute == nil) {
        return NO;
    }
    
    for (FEMRelationship *relationship in mapping.relationships) {
        if (relationship.assignmentPolicy != FEMAssignmentPolicyAssign) {
            return YES;
        }
    }
    
    return NO;
}

FEMObjectCacheSource FEMRealmObjectCacheSource(RLMRealm *realm) {
//    NSMutableDictionary<NSNumber *, NSNumber *> *cache = [[NSMutableDictionary alloc] init];
//    NSMapTable<FEMMapping *, NSNumber *> *cache = [NSMapTable strongToStrongObjectsMapTable];
    
    return ^id<NSFastEnumeration> (FEMMapping *mapping, NSSet *primaryKeys) {
//        NSNumber *shouldPrefetch = [cache objectForKey:mapping];
//        if (shouldPrefetch == nil) {
//            shouldPrefetch = @(FEMMappingRequiresPrefetch(mapping));
//            [cache setObject:shouldPrefetch forKey:mapping];
//        }
//        
//        if ([shouldPrefetch boolValue]) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K IN %@", mapping.primaryKey, primaryKeys];
//            Class realmClass = mapping.objectClass;
            
            //        NSCAssert(
            //            [realmClass isKindOfClass:[RLMObjectBase class]],
            //            @"Attempt to use FastEasyMapping configured for Realm with non-Realm mapping!\n"
            //            "-[FEMMapping objectClass] expected to be kind of <%@>, but appears to be <%@>\n"
            //            "You should not mix mappings for different types (NSObject, NSManagedObject, Realm, etc)",
            //            NSStringFromClass([RLMObjectBase class]),
            //            NSStringFromClass(mapping.objectClass)
            //        );
            
            RLMResults *results = [realm objects:mapping.entityName withPredicate:predicate];
            return results;
    
//        }
        
//        return @[];
    };
}


@implementation FEMObjectCache (Realm)

- (instancetype)initWithMapping:(FEMMapping *)mapping representation:(id)representation realm:(RLMRealm *)realm {
    return [self initWithMapping:mapping representation:representation source:FEMRealmObjectCacheSource(realm)];
}

- (instancetype)initWithRealm:(RLMRealm *)realm {
    return [self initWithSource:FEMRealmObjectCacheSource(realm)];
}

@end
