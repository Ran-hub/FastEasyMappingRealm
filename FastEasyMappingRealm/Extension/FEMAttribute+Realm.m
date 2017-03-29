// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

#import "FEMAttribute+Realm.h"

@implementation FEMAttribute (Realm)

+ (instancetype)rlm_mappingOfStringProperty:(NSString *)property toKeyPath:(nullable NSString *)keyPath {
    return [[self alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]] && [(NSString *)value length] > 0) {
            return value;
        }
        return @"";
    } reverseMap:^id(id value) {
        if ([(NSString *)value length] > 0) {
            return value;
        }

        return nil;
    }];
}

@end
