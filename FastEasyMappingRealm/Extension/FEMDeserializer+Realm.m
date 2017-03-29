// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

#import "FEMDeserializer+Realm.h"
#import "FEMRealmStore.h"

@import Realm.RLMRealm;

@implementation FEMDeserializer (Realm)

- (nonnull instancetype)initWithRealm:(RLMRealm *)realm {
    NSParameterAssert(realm != nil);
    FEMRealmStore *store = [[FEMRealmStore alloc] initWithRealm:realm];
    return [self initWithStore:store];
}

@end
