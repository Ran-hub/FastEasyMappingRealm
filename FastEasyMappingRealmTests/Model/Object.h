//
// Created by zen on 08/09/15.
// Copyright (c) 2015 Yalantis. All rights reserved.
//

@import Foundation;
@import CoreGraphics;

#import <Realm/RLMObject.h>
#import "ChildObject.h"

@class FEMMapping;
@class RLMArray;

NS_ASSUME_NONNULL_BEGIN

@interface Object : RLMObject

@property (nonatomic) BOOL boolValue;
@property (nonatomic, nullable) NSNumber<RLMBool> *boolObject;

@property (nonatomic) BOOL malformedBoolValue; // when JSON contains 1/0 instead of true/false
@property (nonatomic, nullable) NSNumber<RLMBool> *malformedBoolObject; // when JSON contains 1/0 instead of true/false

// Realm 2.6.2 fails to set correct char value correctly leading to 1 instead of expected value. But why does RealmSwift support it?
//@property (nonatomic) char charValue;
//@property (nonatomic, nullable) NSNumber<RLMInt> *charObject;

@property (nonatomic) short shortValue;
@property (nonatomic, nullable) NSNumber<RLMInt> *shortObject;

@property (nonatomic) int intValue;
@property (nonatomic, nullable) NSNumber<RLMInt> *intObject;

@property (nonatomic) long longValue;
@property (nonatomic, nullable) NSNumber<RLMInt> *longObject;

@property (nonatomic) long long longLongValue;
@property (nonatomic, nullable) NSNumber<RLMInt> *longLongObject;

@property (nonatomic) float floatValue;
@property (nonatomic, nullable) NSNumber<RLMFloat> *floatObject;

@property (nonatomic) double doubleValue;
@property (nonatomic, nullable) NSNumber<RLMDouble> *doubleObject;

@property (nonatomic, copy, nullable) NSString *string;
@property (nonatomic, strong, nullable) NSDate *date;
@property (nonatomic, strong, nullable) NSData *data;

@property (nonatomic, strong, nullable) ChildObject *toOneRelationship;
@property RLMArray<ChildObject *><ChildObject> *toManyRelationship;

@end


@interface Object (Mapping)

+ (FEMMapping *)attributesMapping;

+ (FEMMapping *)toOneRelationshipMapping;
+ (FEMMapping *)toManyRelationshipMapping;

@end

NS_ASSUME_NONNULL_END
