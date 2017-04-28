
@import Foundation;

#import <Realm/RLMObject.h>
#import <Realm/RLMArray.h>
#import <FastEasyMapping/FastEasyMapping.h>

#import "UniqueChildObject.h"

@class UniqueChildObject;

@interface UniqueObject : RLMObject

@property (nonatomic) int identifier;

@property (nonatomic, strong) UniqueChildObject *toOneRelationship;
@property (nonatomic, strong) RLMArray<UniqueChildObject *><UniqueChildObject> *toManyRelationship;

@end

@interface UniqueObject (Mapping)

+ (FEMMapping *)defaultMapping;
+ (FEMMapping *)toOneRelationshipMappingWithPolicy:(FEMAssignmentPolicy)policy;
+ (FEMMapping *)toManyRelationshipMappingWithPolicy:(FEMAssignmentPolicy)policy;

@end
