
#import "PerformanceObject.h"

@import FastEasyMapping;

@implementation PerformanceObject

+ (NSString *)primaryKey {
    return @"intValue";
}

@end

@implementation PerformanceObject (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:self];
    mapping.primaryKey = @"intValue";
    
    [mapping addAttributesFromArray:@[
            @"boolValue",
            @"boolObject",
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

- (NSArray<NSDictionary<NSString *, id> *> *)generateTestData:(NSInteger)count {
    NSMutableArray *representation = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        NSString *string = [NSString stringWithFormat:@"String:%zd", i];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:i];
        NSData *data = [string dataUsingEncoding:NSASCIIStringEncoding];
        
        [representation addObject:@{
                                    @"boolValue": @true,
                                    @"boolObject": @true,
                                    @"intValue": @(i),
                                    @"intObject": @(i),
                                    @"nsIntegerValue": @(i),
                                    @"nsIntegerObject": @(i),
                                    @"longValue": @(i),
                                    @"longObject": @(i),
                                    @"longLongValue": @(i),
                                    @"longLongObject": @(i),
                                    @"floatValue": @(i),
                                    @"floatObject": @(i),
                                    @"doubleValue": @(i),
                                    @"doubleObject": @(i),
                                    @"string": string,
                                    @"date": date,
                                    @"data": data
                                    }];
    }
    
    return representation;
}

@end
