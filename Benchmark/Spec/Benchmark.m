
@import XCTest;

@import FastEasyMapping;
@import FastEasyMappingRealm;
@import Realm;

#import "PerformanceObject.h"

const NSInteger ObjectsAmount = 50000;

@interface Benchmark : XCTestCase

@property (nonatomic, strong) RLMRealm *realm;
@property (nonatomic, strong) NSArray *representation;

@end

@implementation Benchmark

- (void)setUp {
    [super setUp];
    
    self.representation = [self generateTestData:ObjectsAmount];
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration new];
    config.inMemoryIdentifier = @"performance_tests";
    self.realm = [RLMRealm realmWithConfiguration:config error:nil];
}

- (void)tearDown {
    self.representation = nil;
    
    [self.realm transactionWithBlock:^{
        [self.realm deleteAllObjects];
    }];
    
    [super tearDown];
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

- (void)testFastEasyMappingInsert {
    FEMRealmStore *store = [[FEMRealmStore alloc] initWithRealm:self.realm];
    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithStore:store];
    FEMMapping *mapping = [PerformanceObject defaultMapping];

    [self measureMetrics:[self.class defaultPerformanceMetrics] automaticallyStartMeasuring:NO forBlock:^{
        [self startMeasuring];
        
        [deserializer collectionFromRepresentation:self.representation mapping:mapping];
        
        [self stopMeasuring];        
        
        [self.realm transactionWithBlock:^{
            [self.realm deleteAllObjects];
        }];
    }];
}

- (void)testFastEasyMappingUpdate {
    FEMRealmStore *store = [[FEMRealmStore alloc] initWithRealm:self.realm];
    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithStore:store];
    FEMMapping *mapping = [PerformanceObject defaultMapping];
    [deserializer collectionFromRepresentation:self.representation mapping:mapping];
    
    [self measureMetrics:[self.class defaultPerformanceMetrics] automaticallyStartMeasuring:NO forBlock:^{
        [self startMeasuring];
        
        [deserializer collectionFromRepresentation:self.representation mapping:mapping];
        
        [self stopMeasuring];
    }];
}

- (void)testRealmPerformanceInsert {
    [self measureMetrics:[self.class defaultPerformanceMetrics] automaticallyStartMeasuring:NO forBlock:^{
        [self startMeasuring];
        
        NSMutableArray *objects = [[NSMutableArray alloc] initWithCapacity:self.representation.count];
        for (NSInteger i = 0; i < self.representation.count; i++) {
            [objects addObject:[[PerformanceObject alloc] initWithValue:self.representation[i]]];
        }
        
        [self.realm beginWriteTransaction];
        [self.realm addOrUpdateObjectsFromArray:objects];
        [self.realm commitWriteTransaction];
        
        [self stopMeasuring];
        
        [self.realm transactionWithBlock:^{
            [self.realm deleteAllObjects];
        }];
    }];
}

- (void)testRealmPerformanceUpdate {
    NSMutableArray *objects = [[NSMutableArray alloc] initWithCapacity:self.representation.count];
    for (NSInteger i = 0; i < self.representation.count; i++) {
        [objects addObject:[[PerformanceObject alloc] initWithValue:self.representation[i]]];
    }
    [self.realm beginWriteTransaction];
    [self.realm addOrUpdateObjectsFromArray:objects];
    [self.realm commitWriteTransaction];
    
    [self measureMetrics:[self.class defaultPerformanceMetrics] automaticallyStartMeasuring:NO forBlock:^{
        [self startMeasuring];
        
        NSMutableArray *objects = [[NSMutableArray alloc] initWithCapacity:self.representation.count];
        for (NSInteger i = 0; i < self.representation.count; i++) {
            [objects addObject:[[PerformanceObject alloc] initWithValue:self.representation[i]]];
        }
        
        [self.realm beginWriteTransaction];
        [self.realm addOrUpdateObjectsFromArray:objects];
        [self.realm commitWriteTransaction];
        
        [self stopMeasuring];
    }];
}

@end
