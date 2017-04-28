
#import <FastEasyMapping/FastEasyMapping.h>
#import "UniqueChildRealmObject.h"

@implementation UniqueChildRealmObject

+ (NSString *)primaryKey {
    return @"identifier";
}

@end

@implementation UniqueChildRealmObject (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:self];
    mapping.primaryKey = [self primaryKey];
    [mapping addAttributesFromArray:@[@"identifier"]];

    return mapping;
}

@end