
@import Foundation;

#import <Realm/RLMObject.h>
#import <Realm/RLMArray.h>
#import <FastEasyMapping/FastEasyMapping.h>

#import "UniqueChildRealmObject.h"

@class UniqueChildRealmObject;

@interface UniqueRealmObject : RLMObject

@property (nonatomic) int identifier;

@property (nonatomic, strong) UniqueChildRealmObject *toOneRelationship;
@property (nonatomic, strong) RLMArray<UniqueChildRealmObject *><UniqueChildRealmObject> *toManyRelationship;

@end

@interface UniqueRealmObject (Mapping)

+ (FEMMapping *)defaultMapping;
+ (FEMMapping *)toOneRelationshipMappingWithPolicy:(FEMAssignmentPolicy)policy;
+ (FEMMapping *)toManyRelationshipMappingWithPolicy:(FEMAssignmentPolicy)policy;

@end
