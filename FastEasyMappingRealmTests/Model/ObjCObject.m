
#import <Realm/Realm.h>
#import <FastEasyMapping/FEMMapping.h>
#import "ObjCObject.h"

@implementation ObjCObject
@end

@implementation ObjCObject (Mapping)

+ (FEMMapping *)attributesMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:self];
    [mapping addAttributesFromArray:@[
        @"boolValue",
        @"boolObject",
        @"malformedBoolValue",
        @"malformedBoolObject",
//        @"charValue",
//        @"charObject",
        @"shortValue",
        @"shortObject",
        @"intValue",
        @"intObject",
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

+ (FEMMapping *)toOneRelationshipMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:self];
    [mapping addAttributesFromArray:@[@"integerProperty"]];
    [mapping addRelationshipMapping:[ObjCChildObject defaultMapping] forProperty:@"toOneRelationship" keyPath:@"toOneRelationship"];

    return mapping;
}

+ (FEMMapping *)toManyRelationshipMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:self];
    [mapping addAttributesFromArray:@[@"integerProperty"]];
    [mapping addToManyRelationshipMapping:[ObjCChildObject defaultMapping] forProperty:@"toManyRelationship" keyPath:@"toManyRelationship"];

    return mapping;
}

@end
