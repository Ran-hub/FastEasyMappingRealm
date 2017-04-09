
@import XCTest;

@import FastEasyMappingRealm;
@import Realm;

#import "PerformanceObject.h"

@interface Benchmark : XCTestCase
@end

@implementation Benchmark

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
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

- (void)testFastEasyMapping {
    NSArray *representation = [self generateTestData:50000];

    RLMRealmConfiguration *config = [RLMRealmConfiguration new];
    config.inMemoryIdentifier = @"performance_tests";
    RLMRealm *realm = [RLMRealm realmWithConfiguration:config error:nil];
    
    FEMRealmStore *store = [[FEMRealmStore alloc] initWithRealm:realm];
    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithStore:store];
    [deserializer collectionFromRepresentation:representation mapping:[PerformanceObject defaultMapping]];
    
    [self measureMetrics:[self.class defaultPerformanceMetrics] automaticallyStartMeasuring:NO forBlock:^{
        
        [self startMeasuring];
        
        [deserializer collectionFromRepresentation:representation mapping:[PerformanceObject defaultMapping]];
        
        [self stopMeasuring];
        
//        [realm transactionWithBlock:^{
//            [realm deleteAllObjects];
//        }];
    }];
}

- (void)testRealmPerformance {
    NSArray *representation = [self generateTestData:50000];
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration new];
    config.inMemoryIdentifier = @"performance_tests";
    RLMRealm *realm = [RLMRealm realmWithConfiguration:config error:nil];
    
    FEMRealmStore *store = [[FEMRealmStore alloc] initWithRealm:realm];
    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithStore:store];
    [deserializer collectionFromRepresentation:representation mapping:[PerformanceObject defaultMapping]];
    
    
    [self measureMetrics:[self.class defaultPerformanceMetrics] automaticallyStartMeasuring:NO forBlock:^{
        [self startMeasuring];
        
        NSMutableArray *objects = [[NSMutableArray alloc] initWithCapacity:representation.count];
        for (NSInteger i = 0; i < representation.count; i++) {
            [objects addObject:[[PerformanceObject alloc] initWithValue:representation[i]]];
        }
        
        [realm beginWriteTransaction];
        [realm addOrUpdateObjectsFromArray:objects];
        [realm commitWriteTransaction];
        
        [self stopMeasuring];
        
//        [realm transactionWithBlock:^{
//            [realm deleteAllObjects];
//        }];
    }];
}

@end
