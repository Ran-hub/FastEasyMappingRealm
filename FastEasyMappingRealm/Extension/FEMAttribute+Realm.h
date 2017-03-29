// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

@import Foundation;

#import <FastEasyMapping/FEMAttribute.h>

NS_ASSUME_NONNULL_BEGIN

@interface FEMAttribute (Realm)

+ (instancetype)rlm_mappingOfStringProperty:(NSString *)property toKeyPath:(nullable NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
