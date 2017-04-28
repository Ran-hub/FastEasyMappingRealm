
@import Foundation;

#import <Realm/RLMObject.h>

NS_ASSUME_NONNULL_BEGIN

@class FEMMapping;

@interface ChildObject : RLMObject

@property (nonatomic) int identifier;

@end

RLM_ARRAY_TYPE(ChildObject)

@interface ChildObject (Mapping)

+ (FEMMapping *)defaultMapping;

@end


NS_ASSUME_NONNULL_END
