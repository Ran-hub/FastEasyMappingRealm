//
// Created by zen on 10/09/15.
// Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "UniqueRealmObject.h"
#import "UniqueChildRealmObject.h"
#import "UniqueToManyChildRealmObject.h"

#import <FastEasyMapping/FastEasyMapping.h>
#import <Realm/Realm.h>

@implementation UniqueRealmObject

+ (NSString *)primaryKey {
    return @"identifier";
}

@end

@implementation UniqueRealmObject (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:self];
    mapping.primaryKey = [self primaryKey];
    [mapping addAttributesFromArray:@[@"identifier"]];

    return mapping;
}

+ (FEMMapping *)toOneRelationshipMappingWithPolicy:(FEMAssignmentPolicy)policy {
    FEMMapping *mapping = [self defaultMapping];

    FEMMapping *relationshipMapping = [[FEMMapping alloc] initWithObjectClass:[UniqueChildRealmObject class]];
    relationshipMapping.primaryKey = @"identifier";
    [relationshipMapping addAttributesFromArray:@[@"identifier"]];

    FEMRelationship *relationship = [[FEMRelationship alloc] initWithProperty:@"toOneRelationship" keyPath:@"toOne" mapping:relationshipMapping];
    relationship.assignmentPolicy = policy;
    [mapping addRelationship:relationship];

    return mapping;
}

+ (FEMMapping *)toManyRelationshipMappingWithPolicy:(FEMAssignmentPolicy)policy {
    FEMMapping *mapping = [self defaultMapping];

    FEMMapping *relationshipMapping = [[FEMMapping alloc] initWithObjectClass:[UniqueToManyChildRealmObject class]];
    relationshipMapping.primaryKey = @"identifier";
    [relationshipMapping addAttributesFromArray:@[@"identifier"]];

    FEMRelationship *relationship = [[FEMRelationship alloc] initWithProperty:@"toManyRelationship" keyPath:@"toMany" mapping:relationshipMapping];
    relationship.toMany = YES;
    relationship.assignmentPolicy = policy;
    [mapping addRelationship:relationship];

    return mapping;
}

@end
