//
// Created by zen on 10/09/15.
// Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "UniqueObject.h"
#import "UniqueChildObject.h"

#import <FastEasyMapping/FastEasyMapping.h>
#import <Realm/Realm.h>

@implementation UniqueObject

+ (NSString *)primaryKey {
    return @"identifier";
}

@end

@implementation UniqueObject (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:self];
    mapping.primaryKey = [self primaryKey];
    [mapping addAttributesFromArray:@[@"identifier"]];

    return mapping;
}

+ (FEMMapping *)toOneRelationshipMappingWithPolicy:(FEMAssignmentPolicy)policy {
    FEMMapping *mapping = [self defaultMapping];

    FEMMapping *child = [UniqueChildObject defaultMapping];
    FEMRelationship *relationship = [[FEMRelationship alloc] initWithProperty:@"toOneRelationship" keyPath:@"toOne" mapping:child];
    relationship.assignmentPolicy = policy;
    [mapping addRelationship:relationship];

    return mapping;
}

+ (FEMMapping *)toManyRelationshipMappingWithPolicy:(FEMAssignmentPolicy)policy {
    FEMMapping *mapping = [self defaultMapping];

    FEMMapping *child = [UniqueChildObject defaultMapping];
    FEMRelationship *relationship = [[FEMRelationship alloc] initWithProperty:@"toManyRelationship" keyPath:@"toMany" mapping:child];
    relationship.toMany = YES;
    relationship.assignmentPolicy = policy;
    [mapping addRelationship:relationship];

    return mapping;
}

@end
