//
// Created by zen on 08/09/15.
// Copyright (c) 2015 Yalantis. All rights reserved.
//

@import Foundation;
@import CoreGraphics;

#import <Realm/RLMObject.h>
#import "ChildRealmObject.h"

@class FEMMapping;
@class RLMArray;

NS_ASSUME_NONNULL_BEGIN

/**
 * Realm 2.5.0
 * Supported types
 * BOOL, bool, int, NSInteger, long, long long, float, double, NSString, NSDate, NSData, and NSNumber tagged with a specific type.
 *
 * Types cheatsheet (https://realm.io/docs/objc/2.5.0/#cheatsheet)
 *
Type	Non-optional	                    Optional
Bool	@property BOOL value;	            @property NSNumber<RLMBool> *value;
Int	    @property int value;	            @property NSNumber<RLMInt> *value;
Float	@property float value;	            @property NSNumber<RLMFloat> *value;
Double	@property double value;	            @property NSNumber<RLMDouble> *value;
String	@property NSString *value; 1	    @property NSString *value;
Data	@property NSData *value; 1	        @property NSData *value;
Date	@property NSDate *value; 1	        @property NSDate *value;
Object	n/a: must be optional	            @property Object *value;
List	@property RLMArray<Object *><Object> *value;	n/a: must be non-optional
LinkingObjects	@property (readonly) RLMLinkingObjects<Object *> *value; 2	n/a: must be non-optional
 */

@interface RealmObject : RLMObject

@property (nonatomic) BOOL boolValue;
@property (nonatomic, nullable) NSNumber<RLMBool> *boolObject;

@property (nonatomic) int intValue;
@property (nonatomic, nullable) NSNumber<RLMInt> *intObject;

@property (nonatomic) NSInteger nsIntegerValue;
@property (nonatomic, nullable) NSNumber<RLMInt> *nsIntegerObject;

@property (nonatomic) long longProperty;
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

@property (nonatomic, strong, nullable) ChildRealmObject *toOneRelationship;
@property RLMArray<ChildRealmObject> *toManyRelationship;

@end


@interface RealmObject (Mapping)

+ (FEMMapping *)attributesMapping;


+ (FEMMapping *)supportedNullableTypesMapping;
+ (FEMMapping *)toOneRelationshipMapping;
+ (FEMMapping *)toManyRelationshipMapping;

@end

NS_ASSUME_NONNULL_END
