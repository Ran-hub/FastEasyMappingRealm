
#import "FEMMapping+Realm.h"

#import <Realm/RLMObjectBase.h>

@implementation FEMMapping (Realm)

- (instancetype)initWithRealmClass:(Class)realmClass {
    NSAssert(
        [realmClass isSubclassOfClass:[RLMObjectBase class]],
         @"%@ expected to be a subclass of %@",
         NSStringFromClass(realmClass),
         NSStringFromClass([RLMObjectBase class])
     );
    
    return [self initWithObjectClass:realmClass];
}

@end
