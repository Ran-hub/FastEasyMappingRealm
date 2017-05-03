// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

#ifndef FEMRealmUtility_h
#define FEMRealmUtility_h

#if !defined(NS_BLOCK_ASSERTIONS)

@import Foundation;
@import Realm.RLMObjectBase;

NS_INLINE void FEMRealmValidateMapping(FEMMapping *mapping) {
    Class realmClass = mapping.objectClass;
    NSCAssert(
        realmClass != nil,
        @"-[FEMMapping objectClass] can't be nil\n"
        "Use -[[FEMMapping alloc] initWithObjectClass:[YourRealmSubclass class]]."
    );
    NSCAssert(
        [realmClass isSubclassOfClass:[RLMObjectBase class]],
        @"-[FEMMapping objectClass] (<%@>) has to be a subclass of RLMObject / RealmSwift.Object class",
        NSStringFromClass(realmClass)
    );
}

#else

NS_INLINE void FEMRealmValidateMapping(FEMMapping *mapping) { /*no-op*/ }

#endif

#endif /* FEMUtility_h */
