
#import "Fixture.h"

@implementation Fixture

+ (nullable NSDictionary *)buildUsingFixture:(NSString *)fileName {
    NSBundle *bundle = [NSBundle bundleForClass:self];
    NSString *path = [bundle pathForResource:fileName ofType:@"json"];

    if (path != nil) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }

    return nil;
}

@end
