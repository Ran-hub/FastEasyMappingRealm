
#import <Realm/Realm.h>
#import <FastEasyMapping/FEMMapping.h>
#import "RealmObject.h"

@implementation RealmObject

//+ (NSDictionary *)defaultPropertyValues {
//    return @{
//        @"string": @"",
//        @"date": [NSDate dateWithTimeIntervalSince1970:0.0],
//        @"data": [NSData data]
//    };
//}

@end

@implementation RealmObject (Mapping)

+ (FEMMapping *)attributesMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self className]];
    [mapping addAttributesFromArray:@[
        @"boolValue",
        @"boolObject",
        @"booleanValue",
        @"intValue",
        @"intObject",
        @"nsIntegerValue",
        @"nsIntegerObject",
        @"longValue",
        @"longObject",
        @"longLongValue",
        @"longLongObject",
        @"floatValue",
        @"floatObject",
        @"doubleValue",
        @"doubleObject",
        @"string"
    ]];

    [mapping addAttribute:[FEMAttribute mappingOfProperty:@"date" toKeyPath:@"date" dateFormat:@"YYYY-mm-dd'T'HH:mm:ssZZZZ"]];
	
	[mapping addAttribute:[FEMAttribute mappingOfProperty:@"data" toKeyPath:@"data" map:^id(id value) {
		if ([value isKindOfClass:[NSString class]]) {
			return [(NSString *)value dataUsingEncoding:NSUTF8StringEncoding];
		}
		return nil;
	} reverseMap:^id(id value) {
		if ([value isKindOfClass:[NSData class]]) {
			return [[NSString alloc] initWithData:value encoding:NSUTF8StringEncoding];
		}
		return nil;
	}]];

    return mapping;
}

+ (FEMMapping *)supportedNullableTypesMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self className]];
    [mapping addAttributesFromArray:@[
        @"boolValue",
        @"booleanValue",
        @"intValue",
        @"integerProperty",
        @"longProperty",
        @"longLongValue",
        @"floatValue",
        @"doubleValue",
        @"cgFloatProperty",
				@"string",
				@"data"
    ]];
	
	[mapping addAttribute:[FEMAttribute mappingOfProperty:@"date" toKeyPath:@"date" dateFormat:@"YYYY-mm-dd'T'HH:mm:ssZZZZ"]];

	[mapping addAttribute:[FEMAttribute mappingOfProperty:@"data" toKeyPath:@"data" map:^id(id value) {
		if ([value isKindOfClass:[NSString class]]) {
			return [(NSString *)value dataUsingEncoding:NSUTF8StringEncoding];
		}
		return nil;
	} reverseMap:^id(id value) {
		if ([value isKindOfClass:[NSData class]]) {
			return [[NSString alloc] initWithData:value encoding:NSUTF8StringEncoding];
		}
		return nil;
	}]];

    return mapping;
}

+ (FEMMapping *)toOneRelationshipMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self className]];
    [mapping addAttributesFromArray:@[@"integerProperty"]];
    [mapping addRelationshipMapping:[ChildRealmObject defaultMapping] forProperty:@"toOneRelationship" keyPath:@"toOneRelationship"];

    return mapping;
}

+ (FEMMapping *)toManyRelationshipMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self className]];
    [mapping addAttributesFromArray:@[@"integerProperty"]];
    [mapping addToManyRelationshipMapping:[ChildRealmObject defaultMapping] forProperty:@"toManyRelationship" keyPath:@"toManyRelationship"];

    return mapping;
}

@end