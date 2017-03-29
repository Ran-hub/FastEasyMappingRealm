// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

@import Foundation;
@import FastEasyMapping.FEMDeserializer;

@class RLMRealm;

NS_ASSUME_NONNULL_BEGIN

@interface FEMDeserializer (Realm)

- (instancetype)initWithRealm:(RLMRealm *)realm;

@end

NS_ASSUME_NONNULL_END
