
#import "ChildObject.h"

#import <FastEasyMapping/FEMMapping.h>

@implementation ChildObject
@end

@implementation ChildObject (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:self];
    [mapping addAttributesFromArray:@[@"identifier"]];
    return mapping;
}

@end
