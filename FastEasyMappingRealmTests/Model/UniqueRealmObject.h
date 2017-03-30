
@import Foundation;

#import <Realm/RLMObject.h>
#import <Realm/RLMArray.h>
#import <FastEasyMapping/FastEasyMapping.h>

#import "UniqueToManyChildRealmObject.h"

@class UniqueChildRealmObject;

@interface UniqueRealmObject : RLMObject

@property (nonatomic) int primaryKey;

@property (nonatomic, strong) UniqueChildRealmObject *toOneRelationship;
@property (nonatomic, strong) RLMArray<UniqueToManyChildRealmObject *><UniqueToManyChildRealmObject> *toManyRelationship;

@end

@interface UniqueRealmObject (Mapping)

+ (FEMMapping *)defaultMapping;
+ (FEMMapping *)toOneRelationshipMappingWithPolicy:(FEMAssignmentPolicy)policy;
+ (FEMMapping *)toManyRelationshipMappingWithPolicy:(FEMAssignmentPolicy)policy;

@end
