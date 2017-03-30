// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Kiwi/Kiwi.h>
#import <FastEasyMapping/FastEasyMapping.h>
#import <FastEasyMappingRealm/FastEasyMappingRealm.h>
#import <Realm/Realm.h>
#import "RealmObject.h"

#import "Fixture.h"

SPEC_BEGIN(FEMDeserializerSpec)
describe(@"FEMDeserializer", ^{
    context(@"deserializing", ^{
        __block RLMRealm *realm = nil;
        __block FEMRealmStore *store = nil;
        __block FEMDeserializer *deserializer = nil;

        beforeEach(^{
            RLMRealmConfiguration *configuration = [[RLMRealmConfiguration alloc] init];
            configuration.inMemoryIdentifier = @"tests";
            realm = [RLMRealm realmWithConfiguration:configuration error:nil];

            store = [[FEMRealmStore alloc] initWithRealm:realm];
            deserializer = [[FEMDeserializer alloc] initWithStore:store];
        });

        afterEach(^{
            realm = nil;
            store = nil;
            deserializer = nil;
        });

        context(@"attributes", ^{
            __block RealmObject *realmObject = nil;

            afterEach(^{
                [realm transactionWithBlock:^{
                    [realm deleteAllObjects];
                }];
                realmObject = nil;
            });

            context(@"nonnull values", ^{
                __block FEMMapping *mapping = nil;

                beforeEach(^{
                    mapping = [RealmObject attributesMapping];
                    NSDictionary *json = [Fixture buildUsingFixture:@"SupportedTypes"];
                    realmObject = [deserializer objectFromRepresentation:json mapping:mapping];
                });

                afterEach(^{
                    mapping = nil;
                });

                it(@"should map BOOL value", ^{
                    BOOL expected = YES;
                    [[@(realmObject.boolValue) should] equal:@(expected)];
                });

                it(@"should map BOOL object", ^{
                    BOOL expected = YES;
                    [[realmObject.boolObject should] equal:@(expected)];
                });

                it(@"should map int value", ^{
                    int expected = INT_MAX;
                    [[@(realmObject.intValue) should] equal:@(expected)];
                });

                it(@"should map int object", ^{
                    int expected = INT_MAX;
                    [[realmObject.intObject should] equal:@(expected)];
                });

                it(@"should map NSInteger value", ^{
                    NSInteger expected = NSIntegerMax;
                    [[@(realmObject.nsIntegerValue) should] equal:@(expected)];
                });

                it(@"should map NSInteger object", ^{
                    NSInteger expected = NSIntegerMax;
                    [[realmObject.nsIntegerObject should] equal:@(expected)];
                });

                it(@"should map long value", ^{
                    long expected = LONG_MAX;
                    [[@(realmObject.longValue) should] equal:@(expected)];
                });

                it(@"should map long object", ^{
                    long expected = LONG_MAX;
                    [[realmObject.longObject should] equal:@(expected)];
                });

                it(@"should map long long value", ^{
                    long long expected = LLONG_MAX;
                    [[@(realmObject.longLongValue) should] equal:@(expected)];
                });

                it(@"should map long long object", ^{
                    long long expected = LLONG_MAX;
                    [[realmObject.longLongObject should] equal:@(expected)];
                });

                it(@"should map float value", ^{
                    float expected = 11.1f;
                    [[@(realmObject.floatValue) should] equal:expected withDelta:0.01f];
                });

                it(@"should map float object", ^{
                    float expected = 11.1f;
                    [[realmObject.floatObject should] equal:expected withDelta:0.01f];
                });

                it(@"should map double value", ^{
                    double expected = 12.2;
                    [[@(realmObject.doubleValue) should] equal:expected withDelta:0.01f];
                });

                it(@"should map float object", ^{
                    double expected = 12.2;
                    [[realmObject.doubleObject should] equal:expected withDelta:0.01f];
                });

                it(@"should map string", ^{
                    NSString *expected = @"string";
                    [[realmObject.string should] equal:expected];
                });

                it(@"should map date", ^{
                    FEMAttribute *attribute = [mapping attributeForProperty:@"date"];
                    NSDate *expected = [attribute mapValue:@"2005-08-09T18:31:42+03"];
                    [[realmObject.date should] equal:expected];
                });

                it(@"should map data", ^{
                    FEMAttribute *attribute = [mapping attributeForProperty:@"data"];
                    NSData *expected = [attribute mapValue:@"utf8"];
                    [[realmObject.data should] equal:expected];
                });
            });

            context(@"null values", ^{
                beforeEach(^{
                    FEMMapping *mapping = [RealmObject attributesMapping];
                    NSDictionary *json = [Fixture buildUsingFixture:@"SupportedNullTypes"];
                    realmObject = [deserializer objectFromRepresentation:json mapping:mapping];
                });

                it(@"should skip BOOL value", ^{
                    [[@(realmObject.boolValue) should] beFalse];
                });

                it(@"should nil BOOL object", ^{
                    [[realmObject.boolObject should] beNil];
                });

                it(@"should skip int value", ^{
                    [[@(realmObject.intValue) should] beZero];
                });

                it(@"should nil int object", ^{
                    [[realmObject.intObject should] beNil];
                });

                it(@"should skip NSInteger value", ^{
                    [[@(realmObject.nsIntegerValue) should] beZero];
                });

                it(@"should nil NSInteger object", ^{
                    [[realmObject.nsIntegerObject should] beNil];
                });

                it(@"should skip long value", ^{
                    [[@(realmObject.longValue) should] beZero];
                });

                it(@"should nil long object", ^{
                    [[realmObject.longObject should] beNil];
                });

                it(@"should skip long long value", ^{
                    [[@(realmObject.longLongValue) should] beZero];
                });

                it(@"should nil long long object", ^{
                    [[realmObject.longLongObject should] beNil];
                });

                it(@"should skip float value", ^{
                    [[@(realmObject.floatValue) should] beZero];
                });

                it(@"should nil float object", ^{
                    [[realmObject.floatObject should] beNil];
                });

                it(@"should skip double value", ^{
                    [[@(realmObject.doubleValue) should] beZero];
                });

                it(@"should map float object", ^{
                    [[realmObject.doubleObject should] beNil];
                });

                it(@"should nil string", ^{
                    [[realmObject.string should] beNil];
                });

                it(@"should nil date", ^{
                    [[realmObject.date should] beNil];
                });

                it(@"should nil data", ^{
                    [[realmObject.data should] beNil];
                });
            });

            context(@"update by null values", ^{
                beforeEach(^{
                    FEMMapping *mapping = [RealmObject attributesMapping];
                    NSDictionary *json = [Fixture buildUsingFixture:@"SupportedTypes"];
                    realmObject = [deserializer objectFromRepresentation:json mapping:mapping];

                    NSDictionary *nullJSON = [Fixture buildUsingFixture:@"SupportedNullTypes"];
                    [deserializer fillObject:realmObject fromRepresentation:nullJSON mapping:mapping];
                });

                it(@"should skip BOOL value", ^{
                    BOOL expected = YES;
                    [[@(realmObject.boolValue) should] equal:@(expected)];
                });

                it(@"should nil BOOL object", ^{
                    [[realmObject.boolObject should] beNil];
                });

                it(@"should skip int value", ^{
                    int expected = INT_MAX;
                    [[@(realmObject.intValue) should] equal:@(expected)];
                });

                it(@"should nil int object", ^{
                    [[realmObject.intObject should] beNil];
                });

                it(@"should skip NSInteger value", ^{
                    NSInteger expected = NSIntegerMax;
                    [[@(realmObject.nsIntegerValue) should] equal:@(expected)];
                });

                it(@"should nil NSInteger object", ^{
                    [[realmObject.nsIntegerObject should] beNil];
                });

                it(@"should skip long value", ^{
                    long expected = LONG_MAX;
                    [[@(realmObject.longValue) should] equal:@(expected)];
                });

                it(@"should nil long object", ^{
                    [[realmObject.longObject should] beNil];
                });

                it(@"should skip long long value", ^{
                    long long expected = LLONG_MAX;
                    [[@(realmObject.longLongValue) should] equal:@(expected)];
                });

                it(@"should nil long long object", ^{
                    [[realmObject.longLongObject should] beNil];
                });

                it(@"should skip float value", ^{
                    float expected = 11.1f;
                    [[@(realmObject.floatValue) should] equal:expected withDelta:0.01f];
                });

                it(@"should nil float object", ^{
                    [[realmObject.floatObject should] beNil];
                });

                it(@"should skip double value", ^{
                    double expected = 12.2;
                    [[@(realmObject.doubleValue) should] equal:expected withDelta:0.01f];
                });

                it(@"should nil float object", ^{
                    [[realmObject.doubleObject should] beNil];
                });

                it(@"should nil string", ^{
                    [[realmObject.string should] beNil];
                });

                it(@"should nil date", ^{
                    [[realmObject.date should] beNil];
                });

                it(@"should nil data", ^{
                    [[realmObject.data should] beNil];
                });
            });
        });


//        context(@"to-one relationship", ^{
//            context(@"nonnull value", ^{
//                __block RealmObject *realmObject = nil;
//                __block ChildRealmObject *childRealmObject = nil;
//
//                beforeEach(^{
//                    FEMMapping *mapping = [RealmObject toOneRelationshipMapping];
//                    NSDictionary *json = [Fixture buildUsingFixture:@"ToOneRelationship"];
//                    realmObject = [deserializer objectFromRepresentation:json mapping:mapping];
//                    childRealmObject = realmObject.toOneRelationship;
//                });
//
//                specify(^{
//                    [[realmObject.toOneRelationship shouldNot] beNil];
//                    [[@([realmObject.toOneRelationship isEqualToObject:childRealmObject]) should] beTrue];
//                });
//
//                specify(^{
//                    [[@(childRealmObject.identifier) should] equal:@(10)];
//                });
//            });
//
//            context(@"null value", ^{
//                __block RealmObject *realmObject = nil;
//                beforeEach(^{
//                    FEMMapping *mapping = [RealmObject toOneRelationshipMapping];
//                    NSDictionary *json = [Fixture buildUsingFixture:@"ToOneNullRelationship"];
//                    realmObject = [deserializer objectFromRepresentation:json mapping:mapping];
//                });
//
//                specify(^{
//                    [[realmObject.toOneRelationship should] beNil];
//                });
//            });
//        });
//
//        context(@"to-many relationship", ^{
//            context(@"nonnull value", ^{
//                __block RealmObject *realmObject = nil;
//                __block RLMArray<ChildRealmObject> *relationship = nil;
//
//                beforeEach(^{
//                    FEMMapping *mapping = [RealmObject toManyRelationshipMapping];
//                    NSDictionary *json = [Fixture buildUsingFixture:@"ToManyRelationship"];
//                    realmObject = [deserializer objectFromRepresentation:json mapping:mapping];
//                    relationship = realmObject.toManyRelationship;
//                });
//
//                specify(^{
//                    [[relationship shouldNot] beNil];
//                    [[@(relationship.count) should] equal:@(2)];
//                });
//
//                specify(^{
//                    ChildRealmObject *child0 = relationship[0];
//                    [[@(child0.identifier) should] equal:@(20)];
//
//                    ChildRealmObject *child1 = relationship[1];
//                    [[@(child1.identifier) should] equal:@(21)];
//                });
//            });
//
//            context(@"null value", ^{
//                __block RealmObject *realmObject = nil;
//                __block RLMArray<ChildRealmObject> *relationship = nil;
//
//                beforeEach(^{
//                    FEMMapping *mapping = [RealmObject toManyRelationshipMapping];
//                    NSDictionary *json = [Fixture buildUsingFixture:@"ToManyNullRelationship"];
//                    realmObject = [deserializer objectFromRepresentation:json mapping:mapping];
//                    relationship = realmObject.toManyRelationship;
//                });
//
//                specify(^{
//                    [[@(relationship.count) should] equal:@(0)];
//                });
//            });
//        });
    });
});

SPEC_END
