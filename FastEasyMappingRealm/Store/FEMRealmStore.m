// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

#import "FEMRealmStore.h"

@import FastEasyMapping.FEMMapping;
@import Realm.RLMRealm;
@import Realm.RLMObject;
@import Realm.Dynamic;

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

- (void)prepareTransactionForMapping:(nonnull FEMMapping *)mapping ofRepresentation:(nonnull NSArray *)representation {
}

- (void)beginTransaction {
    [_realm beginWriteTransaction];
}

- (NSError *)commitTransaction {
    [_realm commitWriteTransaction];
    
    return nil;
}

- (id)newObjectForMapping:(FEMMapping *)mapping {
    Class realmObjectClass = NSClassFromString(mapping.entityName);
    RLMObject *object = [(RLMObject *)[realmObjectClass alloc] init];

    return object;
}

- (id)registeredObjectForRepresentation:(id)representation mapping:(FEMMapping *)mapping {
    FEMAttribute *pk = mapping.primaryKeyAttribute;
    if (pk != nil) {
        id pkValue = [pk mapValue:[representation valueForKeyPath:pk.keyPath]];
        return [_realm objectWithClassName:mapping.entityName forPrimaryKey:pkValue];
    } else {
        return nil;
    }
}

- (void)registerObject:(id)object forMapping:(FEMMapping *)mapping {
    if ([self canRegisterObject:object forMapping:mapping]) {
        [_realm addObject:object];
    }
}

- (BOOL)canRegisterObject:(id)object forMapping:(FEMMapping *)mapping {
    return [(RLMObject *)object realm] == nil;
}

#pragma mark - FEMRelationshipAssignmentContextDelegate

- (void)assignmentContext:(FEMRelationshipAssignmentContext *)context deletedObject:(id)object {
    RLMObject *rlmObject = object;
    if (rlmObject.realm == _realm) {
        [_realm deleteObject:rlmObject];
    }
}

@end
