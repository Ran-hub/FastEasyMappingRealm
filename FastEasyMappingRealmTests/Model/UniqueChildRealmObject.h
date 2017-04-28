
@import Foundation;

#import <Realm/RLMObject.h>

@class FEMMapping;

@interface UniqueChildRealmObject : RLMObject

@property (nonatomic) int identifier;

@end


@interface UniqueChildRealmObject (Mapping)

+ (FEMMapping *)defaultMapping;

@end

RLM_ARRAY_TYPE(UniqueChildRealmObject);
