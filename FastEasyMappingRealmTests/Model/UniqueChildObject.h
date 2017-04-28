
@import Foundation;

#import <Realm/RLMObject.h>

@class FEMMapping;

@interface UniqueChildObject : RLMObject

@property (nonatomic) int identifier;

@end


@interface UniqueChildObject (Mapping)

+ (FEMMapping *)defaultMapping;

@end

RLM_ARRAY_TYPE(UniqueChildObject);
