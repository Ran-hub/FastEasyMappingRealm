// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

@import Foundation;
@import FastEasyMapping.FEMObjectCache;

@class RLMRealm;

NS_ASSUME_NONNULL_BEGIN

@interface FEMObjectCache (Realm)

- (instancetype)initWithMapping:(FEMMapping *)mapping representation:(id)representation realm:(RLMRealm *)realm;

- (instancetype)initWithRealm:(RLMRealm *)realm;

@end

NS_ASSUME_NONNULL_END
