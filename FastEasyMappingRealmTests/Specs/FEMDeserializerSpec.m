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

            afterAll(^{
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

                it(@"should map BOOL", ^{
                    BOOL expected = YES;
                    [[@(realmObject.boolValue) should] equal:@(expected)];
                });

                it(@"should map boolean", ^{
                    bool expected = true;
                    [[@(realmObject.booleanValue) should] equal:@(expected)];
                });

            
                
                specify(^{
                    int expected = 3;
                    [[@(realmObject.intValue) should] equal:@(expected)];
                });

                specify(^{
                    NSInteger expected = 5;
                    [[@(realmObject.integerProperty) should] equal:@(expected)];
                });

                specify(^{
                    long expected = 7;
                    [[@(realmObject.longProperty) should] equal:@(expected)];
                });

                specify(^{
                    long long expected = 9;
                    [[@(realmObject.longLongValue) should] equal:@(expected)];
                });

                specify(^{
                    float expected = 11.1f;
                    [[@(realmObject.floatValue) should] equal:expected withDelta:0.01f];
                });

                specify(^{
                    double expected = 12.2;
                    [[@(realmObject.doubleValue) should] equal:expected withDelta:0.01f];
                });

                specify(^{
                    CGFloat expected = 13.3;
                    [[@(realmObject.cgFloatProperty) should] equal:expected withDelta:0.01f];
                });

                specify(^{
                    NSString *expected = @"string";
                    [[realmObject.string should] equal:expected];
                });

                specify(^{
                    FEMAttribute *attribute = [mapping attributeForProperty:@"date"];
                    NSDate *expected = [attribute mapValue:@"2005-08-09T18:31:42+03"];
                    [[realmObject.date should] equal:expected];
                });

                specify(^{
                    FEMAttribute *attribute = [mapping attributeForProperty:@"data"];
                    NSData *expected = [attribute mapValue:@"utf8"];
                    [[realmObject.data should] equal:expected];
                });
            });

            context(@"null values", ^{
                beforeEach(^{
                    FEMMapping *mapping = [RealmObject supportedNullableTypesMapping];
                    NSDictionary *json = [Fixture buildUsingFixture:@"SupportedNullTypes"];
                    realmObject = [deserializer objectFromRepresentation:json mapping:mapping];
                });

                specify(^{
                    BOOL expected = NO;
                    [[@(realmObject.boolValue) should] equal:@(expected)];
                });

                specify(^{
                    bool expected = false;
                    [[@(realmObject.booleanValue) should] equal:@(expected)];
                });

                specify(^{
                    int expected = 0;
                    [[@(realmObject.intValue) should] equal:@(expected)];
                });

                specify(^{
                    NSInteger expected = 0;
                    [[@(realmObject.integerProperty) should] equal:@(expected)];
                });

                specify(^{
                    long expected = 0;
                    [[@(realmObject.longProperty) should] equal:@(expected)];
                });

                specify(^{
                    long long expected = 0;
                    [[@(realmObject.longLongValue) should] equal:@(expected)];
                });

                specify(^{
                    float expected = 0.f;
                    [[@(realmObject.floatValue) should] equal:expected withDelta:0.01f];
                });

                specify(^{
                    double expected = 0.0;
                    [[@(realmObject.doubleValue) should] equal:expected withDelta:0.01f];
                });

                specify(^{
                    CGFloat expected = 0.0;
                    [[@(realmObject.cgFloatProperty) should] equal:expected withDelta:0.01f];
                });
            });

            context(@"update by null values", ^{
                beforeAll(^{
                    FEMMapping *mapping = [RealmObject attributesMapping];
                    NSDictionary *json = [Fixture buildUsingFixture:@"SupportedTypes"];
                    realmObject = [deserializer objectFromRepresentation:json mapping:mapping];

                    FEMMapping *nullMapping = [RealmObject supportedNullableTypesMapping];
                    NSDictionary *nullJSON = [Fixture buildUsingFixture:@"SupportedNullTypes"];
                    [deserializer fillObject:realmObject fromRepresentation:nullJSON mapping:nullMapping];
                });

                specify(^{
                    BOOL expected = YES;
                    [[@(realmObject.boolValue) should] equal:@(expected)];
                });

                specify(^{
                    bool expected = true;
                    [[@(realmObject.booleanValue) should] equal:@(expected)];
                });

                specify(^{
                    int expected = 3;
                    [[@(realmObject.intValue) should] equal:@(expected)];
                });

                specify(^{
                    NSInteger expected = 5;
                    [[@(realmObject.integerProperty) should] equal:@(expected)];
                });

                specify(^{
                    long expected = 7;
                    [[@(realmObject.longProperty) should] equal:@(expected)];
                });

                specify(^{
                    long long expected = 9;
                    [[@(realmObject.longLongValue) should] equal:@(expected)];
                });

                specify(^{
                    float expected = 11.1f;
                    [[@(realmObject.floatValue) should] equal:expected withDelta:0.01f];
                });

                specify(^{
                    double expected = 12.2;
                    [[@(realmObject.doubleValue) should] equal:expected withDelta:0.01f];
                });

                specify(^{
                    CGFloat expected = 13.3;
                    [[@(realmObject.cgFloatProperty) should] equal:expected withDelta:0.01f];
                });

                // Not yet supported by Realm <= 0.95.0
                specify(^{
                    [[realmObject.string should] beNil];
                });

                specify(^{
                    [[realmObject.date should] beNil];
                });

                specify(^{
                    [[realmObject.data should] beNil];
                });
            });
        });


        context(@"to-one relationship", ^{
            context(@"nonnull value", ^{
                __block RealmObject *realmObject = nil;
                __block ChildRealmObject *childRealmObject = nil;

                beforeEach(^{
                    FEMMapping *mapping = [RealmObject toOneRelationshipMapping];
                    NSDictionary *json = [Fixture buildUsingFixture:@"ToOneRelationship"];
                    realmObject = [deserializer objectFromRepresentation:json mapping:mapping];
                    childRealmObject = realmObject.toOneRelationship;
                });

                specify(^{
                    [[realmObject.toOneRelationship shouldNot] beNil];
                    [[@([realmObject.toOneRelationship isEqualToObject:childRealmObject]) should] beTrue];
                });

                specify(^{
                    [[@(childRealmObject.identifier) should] equal:@(10)];
                });
            });

            context(@"null value", ^{
                __block RealmObject *realmObject = nil;
                beforeEach(^{
                    FEMMapping *mapping = [RealmObject toOneRelationshipMapping];
                    NSDictionary *json = [Fixture buildUsingFixture:@"ToOneNullRelationship"];
                    realmObject = [deserializer objectFromRepresentation:json mapping:mapping];
                });

                specify(^{
                    [[realmObject.toOneRelationship should] beNil];
                });
            });
        });

        context(@"to-many relationship", ^{
            context(@"nonnull value", ^{
                __block RealmObject *realmObject = nil;
                __block RLMArray<ChildRealmObject> *relationship = nil;

                beforeEach(^{
                    FEMMapping *mapping = [RealmObject toManyRelationshipMapping];
                    NSDictionary *json = [Fixture buildUsingFixture:@"ToManyRelationship"];
                    realmObject = [deserializer objectFromRepresentation:json mapping:mapping];
                    relationship = realmObject.toManyRelationship;
                });

                specify(^{
                    [[relationship shouldNot] beNil];
                    [[@(relationship.count) should] equal:@(2)];
                });

                specify(^{
                    ChildRealmObject *child0 = relationship[0];
                    [[@(child0.identifier) should] equal:@(20)];

                    ChildRealmObject *child1 = relationship[1];
                    [[@(child1.identifier) should] equal:@(21)];
                });
            });

            context(@"null value", ^{
                __block RealmObject *realmObject = nil;
                __block RLMArray<ChildRealmObject> *relationship = nil;

                beforeEach(^{
                    FEMMapping *mapping = [RealmObject toManyRelationshipMapping];
                    NSDictionary *json = [Fixture buildUsingFixture:@"ToManyNullRelationship"];
                    realmObject = [deserializer objectFromRepresentation:json mapping:mapping];
                    relationship = realmObject.toManyRelationship;
                });

                specify(^{
                    [[@(relationship.count) should] equal:@(0)];
                });
            });
        });
    });
});

SPEC_END
