
@import Foundation;

#import <Realm/RLMObject.h>

NS_ASSUME_NONNULL_BEGIN

@class FEMMapping;

@interface ChildRealmObject : RLMObject

@property (nonatomic) NSInteger identifier;

@end

RLM_ARRAY_TYPE(ChildRealmObject)

@interface ChildRealmObject (Mapping)

+ (FEMMapping *)defaultMapping;

@end


NS_ASSUME_NONNULL_END