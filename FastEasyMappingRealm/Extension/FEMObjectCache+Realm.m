// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

#import "FEMObjectCache+Realm.h"

@import FastEasyMapping.FEMMapping;

@import Realm.RLMRealm;
@import Realm.RLMResults;
@import Realm.RLMObjectBase;
@import Realm.Dynamic;

FEMObjectCacheSource FEMRealmObjectCacheSource(RLMRealm *realm) {
    return ^id<NSFastEnumeration> (FEMMapping *mapping, NSSet *primaryKeys) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K IN %@", mapping.primaryKey, primaryKeys];
        Class realmClass = mapping.objectClass;

//        NSCAssert(
//            [realmClass isKindOfClass:[RLMObjectBase class]],
//            @"Attempt to use FastEasyMapping configured for Realm with non-Realm mapping!\n"
//            "-[FEMMapping objectClass] expected to be kind of <%@>, but appears to be <%@>\n"
//            "You should not mix mappings for different types (NSObject, NSManagedObject, Realm, etc)",
//            NSStringFromClass([RLMObjectBase class]),
//            NSStringFromClass(mapping.objectClass)
//        );

//        return @[];
        RLMResults *results = [realm objects:mapping.entityName withPredicate:predicate];
        return results;
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
