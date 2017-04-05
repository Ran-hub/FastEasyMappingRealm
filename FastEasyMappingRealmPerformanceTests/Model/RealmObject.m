
#import "RealmObject.h"

@import FastEasyMapping;

@implementation RealmObject
@end

@implementation RealmObject (Mapping)

+ (FEMMapping *)defaultMapping {
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
            @"string",
            @"date",
            @"data"
    ]];

    return mapping;
}

@end