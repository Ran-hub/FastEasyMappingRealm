
@import Foundation;

#import <Realm/RLMObject.h>

NS_ASSUME_NONNULL_BEGIN

@class FEMMapping;

@interface ObjCChildObject : RLMObject

@property (nonatomic) int identifier;

@end

RLM_ARRAY_TYPE(ObjCChildObject)

@interface ObjCChildObject (Mapping)

+ (FEMMapping *)defaultMapping;

@end


NS_ASSUME_NONNULL_END
