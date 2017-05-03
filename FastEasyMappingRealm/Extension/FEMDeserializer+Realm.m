// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

#import "FEMDeserializer+Realm.h"
#import "FEMRealmStore.h"

#import "FEMRealmUtility.h"

@import Realm.RLMRealm;

@implementation FEMDeserializer (Realm)

- (nonnull instancetype)initWithRealm:(RLMRealm *)realm {
    NSParameterAssert(realm != nil);
    
    FEMRealmStore *store = [[FEMRealmStore alloc] initWithRealm:realm];
    return [self initWithStore:store];
}

+ (id)objectFromRepresentation:(NSDictionary *)representation mapping:(FEMMapping *)mapping realm:(RLMRealm *)realm {
    FEMRealmValidateMapping(mapping);
    
    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithRealm:realm];
    return [deserializer objectFromRepresentation:representation mapping:mapping];
}

+ (id)fillObject:(id)object fromRepresentation:(NSDictionary *)representation mapping:(FEMMapping *)mapping realm:(RLMRealm *)realm {
    FEMRealmValidateMapping(mapping);
    
    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithRealm:realm];
    return [deserializer fillObject:object fromRepresentation:representation mapping:mapping];
}


+ (NSArray *)collectionFromRepresentation:(NSArray *)representation mapping:(FEMMapping *)mapping realm:(RLMRealm *)realm {
    FEMRealmValidateMapping(mapping);
    
    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithRealm:realm];
    return [deserializer collectionFromRepresentation:representation mapping:mapping];
}

@end
