// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

@import Foundation;

#import <FastEasyMapping/FEMObjectStore.h>

@class RLMRealm;

NS_ASSUME_NONNULL_BEGIN

@interface FEMRealmStore : FEMObjectStore

@property (nonatomic, strong, readonly) RLMRealm *realm;

- (instancetype)initWithRealm:(RLMRealm *)realm;

@end

NS_ASSUME_NONNULL_END
