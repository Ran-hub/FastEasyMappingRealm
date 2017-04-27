
#import "ObjCChildObject.h"

#import <FastEasyMapping/FEMMapping.h>

@implementation ObjCChildObject
@end

@implementation ObjCChildObject (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:self];
    [mapping addAttributesFromArray:@[@"identifier"]];
    return mapping;
}

@end
