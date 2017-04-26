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
    Class realmClass = mapping.objectClass;

    NSAssert(realmClass != nil, @"-[FEMMapping objectClass] can't be nil");
    NSAssert(
        [realmClass isSubclassOfClass:[RLMObjectBase class]],
        @"-[FEMMapping objectClass] (<%@>) has to be a subclass of RLMObjectBase class",
        NSStringFromClass(realmClass)
    );

    RLMObjectBase *object = [(RLMObjectBase *)[realmClass alloc] init];
    return object;
}

- (nullable id)objectForPrimaryKey:(id)primaryKey mapping:(FEMMapping *)mapping {
    return [_realm objectWithClassName:[mapping.objectClass className] forPrimaryKey:primaryKey];
}

- (void)addObject:(id)object forPrimaryKey:(nullable id)primaryKey mapping:(FEMMapping *)mapping {
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
