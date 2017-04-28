
#import <FastEasyMapping/FastEasyMapping.h>
#import "UniqueChildObject.h"

@implementation UniqueChildObject

+ (NSString *)primaryKey {
    return @"identifier";
}

@end

@implementation UniqueChildObject (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:self];
    mapping.primaryKey = [self primaryKey];
    [mapping addAttributesFromArray:@[@"identifier"]];

    return mapping;
}

@end