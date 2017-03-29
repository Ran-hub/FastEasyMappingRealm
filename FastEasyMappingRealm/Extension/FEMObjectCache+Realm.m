// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

#import "FEMObjectCache+Realm.h"
#import <FastEasyMapping/FEMMapping.h>

#import <Realm/RLMRealm.h>
#import <Realm/RLMRealm_Dynamic.h>
#import <Realm/RLMResults.h>

@implementation FEMObjectCache (Realm)

- (instancetype)initWithMapping:(FEMMapping *)mapping representation:(id)representation realm:(RLMRealm *)realm {
    return [self initWithMapping:mapping representation:representation source:^id<NSFastEnumeration> (FEMMapping *objectMapping, NSSet *primaryKeys) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K IN %@", objectMapping.primaryKey, primaryKeys];
        RLMResults *results = [realm objects:objectMapping.entityName withPredicate:predicate];
        return results;
    }];
}

- (instancetype)initWithRealm:(RLMRealm *)realm {
    return [self initWithSource:^id <NSFastEnumeration>(FEMMapping *objectMapping, NSSet *primaryKeys) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K IN %@", objectMapping.primaryKey, primaryKeys];
        RLMResults *results = [realm objects:objectMapping.entityName withPredicate:predicate];
        return results;
    }];
}

@end
