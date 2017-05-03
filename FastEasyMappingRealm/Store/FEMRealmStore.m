// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

#import "FEMRealmStore.h"

@import FastEasyMapping.FEMMapping;
@import Realm.RLMRealm;
@import Realm.RLMObject;
@import Realm.Dynamic;

#import "FEMRealmUtility.h"

@implementation FEMRealmStore

- (instancetype)initWithRealm:(RLMRealm *)realm {
    NSParameterAssert(realm != nil);

    self = [super init];
    if (self) {
        _realm = realm;
    }

    return self;
}

#pragma mark - Transaction

+ (BOOL)requiresPrefetch {
    return NO;
}

- (void)beginTransaction:(nullable NSMapTable<FEMMapping *, NSSet<id> *> *)presentedPrimaryKeys {
    [_realm beginWriteTransaction];
}

- (NSError *)commitTransaction {
    [_realm commitWriteTransaction];
    
    return nil;
}

- (id)newObjectForMapping:(FEMMapping *)mapping {
    FEMRealmValidateMapping(mapping);

    Class realmClass = mapping.objectClass;
    RLMObjectBase *object = [(RLMObjectBase *)[realmClass alloc] init];
    return object;
}

- (nullable id)objectForPrimaryKey:(id)primaryKey mapping:(FEMMapping *)mapping {
    FEMRealmValidateMapping(mapping);
    
    return [_realm objectWithClassName:[mapping.objectClass className] forPrimaryKey:primaryKey];
}

- (void)addObject:(id)object forPrimaryKey:(nullable id)primaryKey mapping:(FEMMapping *)mapping {
    FEMRealmValidateMapping(mapping);
    
    if ([(RLMObject *)object realm] != _realm) {
        [_realm addObject:object];  
    }
}

#pragma mark - FEMRelationshipAssignmentContextDelegate

- (void)assignmentContext:(FEMRelationshipAssignmentContext *)context deletedObject:(id)object {
    RLMObject *rlmObject = object;
    if (rlmObject.realm == _realm) {
        [_realm deleteObject:rlmObject];
    }
}

@end
