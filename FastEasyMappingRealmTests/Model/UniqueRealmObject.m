//
// Created by zen on 10/09/15.
// Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "UniqueRealmObject.h"
#import "UniqueChildRealmObject.h"

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

    FEMMapping *child = [UniqueChildRealmObject defaultMapping];
    FEMRelationship *relationship = [[FEMRelationship alloc] initWithProperty:@"toOneRelationship" keyPath:@"toOne" mapping:child];
    relationship.assignmentPolicy = policy;
    [mapping addRelationship:relationship];

    return mapping;
}

+ (FEMMapping *)toManyRelationshipMappingWithPolicy:(FEMAssignmentPolicy)policy {
    FEMMapping *mapping = [self defaultMapping];

    FEMMapping *child = [UniqueChildRealmObject defaultMapping];
    FEMRelationship *relationship = [[FEMRelationship alloc] initWithProperty:@"toManyRelationship" keyPath:@"toMany" mapping:child];
    relationship.toMany = YES;
    relationship.assignmentPolicy = policy;
    [mapping addRelationship:relationship];

    return mapping;
}

@end
