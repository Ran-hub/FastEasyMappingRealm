
#import "ChildRealmObject.h"

#import <FastEasyMapping/FEMMapping.h>

@implementation ChildRealmObject
@end

@implementation ChildRealmObject (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:self];
    [mapping addAttributesFromArray:@[@"identifier"]];
    return mapping;
}

@end
