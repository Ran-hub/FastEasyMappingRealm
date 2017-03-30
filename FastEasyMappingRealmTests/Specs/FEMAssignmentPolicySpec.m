// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Kiwi/Kiwi.h>
#import <FastEasyMapping/FastEasyMapping.h>
#import <FastEasyMappingRealm/FastEasyMappingRealm.h>
#import <Realm/Realm.h>

#import "RealmObject.h"
#import "UniqueRealmObject.h"
#import "UniqueToManyChildRealmObject.h"
#import "FEMRealmAssignmentPolicy.h"
#import "Fixture.h"
#import "UniqueChildRealmObject.h"

SPEC_BEGIN(FEMAssignmentPolicySpec)
describe(@"FEMAssignmentPolicy", ^{
    __block RLMRealm *realm = nil;
    __block FEMRealmStore *store = nil;
    __block FEMDeserializer *deserializer = nil;

    beforeEach(^{
        RLMRealmConfiguration *configuration = [[RLMRealmConfiguration alloc] init];
        configuration.inMemoryIdentifier = @"assignment_policy_tests";
        realm = [RLMRealm realmWithConfiguration:configuration error:nil];

        store = [[FEMRealmStore alloc] initWithRealm:realm];
        deserializer = [[FEMDeserializer alloc] initWithStore:store];
    });

    afterEach(^{
        realm = nil;
        store = nil;
        deserializer = nil;
    });

    // Since FEMRealm doesn't introduce assignment policies for to-one relationship - we don't re-test them here.

    context(@"to-many relationship", ^{
        __block FEMMapping *mapping = nil;
        context(@"assign", ^{
            __block UniqueRealmObject *object = nil;
            beforeEach(^{
                mapping = [UniqueRealmObject toManyRelationshipMappingWithPolicy:FEMAssignmentPolicyAssign];
                NSDictionary *fixture0 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyInit"];
                object = [deserializer objectFromRepresentation:fixture0 mapping:mapping];
            });

            afterEach(^{
               [realm transactionWithBlock:^{
                   [realm deleteAllObjects];
               }];
            });

            it(@"should assign value", ^{
                [[@(object.primaryKey) should] equal:@5];
                [[@(object.toManyRelationship.count) should] equal:@2];

                UniqueToManyChildRealmObject *child0 = object.toManyRelationship[0];
                [[@(child0.primaryKey) should] equal:@10];
                UniqueToManyChildRealmObject *child1 = object.toManyRelationship[1];
                [[@(child1.primaryKey) should] equal:@11];
            });

            it(@"should re-assign value", ^{
                NSDictionary *fixture1 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyUpdate"];
                [deserializer fillObject:object fromRepresentation:fixture1 mapping:mapping];

                [[@(object.primaryKey) should] equal:@5];
                [[@(object.toManyRelationship.count) should] equal:@2];

                UniqueToManyChildRealmObject *child0 = object.toManyRelationship[0];
                [[@(child0.primaryKey) should] equal:@11];
                UniqueToManyChildRealmObject *child1 = object.toManyRelationship[1];
                [[@(child1.primaryKey) should] equal:@12];

                [[@([UniqueToManyChildRealmObject allObjectsInRealm:realm].count) should] equal:@3];
                [[@([UniqueToManyChildRealmObject objectsInRealm:realm where:@"primaryKey == 10"].count) shouldNot] beZero];
            });

            it(@"should assign null", ^{
                NSDictionary *fixture2 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyNull"];
                [deserializer fillObject:object fromRepresentation:fixture2 mapping:mapping];

                [[@(object.primaryKey) should] equal:@5];
                [[@(object.toManyRelationship.count) should] equal:@0];

                [[@([UniqueToManyChildRealmObject allObjectsInRealm:realm].count) should] equal:@2];
                [[@([UniqueToManyChildRealmObject objectsInRealm:realm where:@"primaryKey == 10"].count) shouldNot] beZero];
                [[@([UniqueToManyChildRealmObject objectsInRealm:realm where:@"primaryKey == 11"].count) shouldNot] beZero];
            });
        });

        context(@"merge", ^{
            __block UniqueRealmObject *object = nil;
            beforeEach(^{
                mapping = [UniqueRealmObject toManyRelationshipMappingWithPolicy:FEMRealmAssignmentPolicyCollectionMerge];
                NSDictionary *fixture0 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyInit"];
                object = [deserializer objectFromRepresentation:fixture0 mapping:mapping];
            });

            afterEach(^{
                [realm transactionWithBlock:^{
                    [realm deleteAllObjects];
                }];
            });

            it(@"should assign value", ^{
                [[@(object.primaryKey) should] equal:@5];
                [[@(object.toManyRelationship.count) should] equal:@2];

                UniqueToManyChildRealmObject *child0 = object.toManyRelationship[0];
                [[@(child0.primaryKey) should] equal:@10];
                UniqueToManyChildRealmObject *child1 = object.toManyRelationship[1];
                [[@(child1.primaryKey) should] equal:@11];

                [[@([UniqueToManyChildRealmObject allObjectsInRealm:realm].count) should] equal:@2];
            });

            it(@"should merge values", ^{
                NSDictionary *fixture1 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyUpdate"];
                [deserializer fillObject:object fromRepresentation:fixture1 mapping:mapping];

                [[@(object.primaryKey) should] equal:@5];
                [[@(object.toManyRelationship.count) should] equal:@3];

                UniqueToManyChildRealmObject *child0 = object.toManyRelationship[0];
                [[@(child0.primaryKey) should] equal:@10];
                UniqueToManyChildRealmObject *child1 = object.toManyRelationship[1];
                [[@(child1.primaryKey) should] equal:@11];
                UniqueToManyChildRealmObject *child2 = object.toManyRelationship[2];
                [[@(child2.primaryKey) should] equal:@12];

                [[@([UniqueToManyChildRealmObject allObjectsInRealm:realm].count) should] equal:@3];
            });

            it(@"should ignore null value", ^{
                NSDictionary *fixture2 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyNull"];
                [deserializer fillObject:object fromRepresentation:fixture2 mapping:mapping];

                [[@(object.primaryKey) should] equal:@5];
                [[@(object.toManyRelationship.count) should] equal:@2];

                UniqueToManyChildRealmObject *child0 = object.toManyRelationship[0];
                [[@(child0.primaryKey) should] equal:@10];
                UniqueToManyChildRealmObject *child1 = object.toManyRelationship[1];
                [[@(child1.primaryKey) should] equal:@11];

                [[@([UniqueToManyChildRealmObject allObjectsInRealm:realm].count) should] equal:@2];
            });

            it(@"should ignore empty array", ^{
                NSDictionary *fixture3 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyEmptyArray"];
                [deserializer fillObject:object fromRepresentation:fixture3 mapping:mapping];

                [[@(object.primaryKey) should] equal:@5];
                [[@(object.toManyRelationship.count) should] equal:@2];

                UniqueToManyChildRealmObject *child0 = object.toManyRelationship[0];
                [[@(child0.primaryKey) should] equal:@10];
                UniqueToManyChildRealmObject *child1 = object.toManyRelationship[1];
                [[@(child1.primaryKey) should] equal:@11];

                [[@([UniqueToManyChildRealmObject allObjectsInRealm:realm].count) should] equal:@2];
            });
        });

        context(@"replace", ^{
            __block UniqueRealmObject *object = nil;
            beforeEach(^{
                mapping = [UniqueRealmObject toManyRelationshipMappingWithPolicy:FEMRealmAssignmentPolicyCollectionReplace];
                NSDictionary *fixture0 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyInit"];
                object = [deserializer objectFromRepresentation:fixture0 mapping:mapping];
            });

            afterEach(^{
                [realm transactionWithBlock:^{
                    [realm deleteAllObjects];
                }];
            });

            it(@"should assign value", ^{
                [[@(object.primaryKey) should] equal:@5];
                [[@(object.toManyRelationship.count) should] equal:@2];

                UniqueToManyChildRealmObject *child0 = object.toManyRelationship[0];
                [[@(child0.primaryKey) should] equal:@10];
                UniqueToManyChildRealmObject *child1 = object.toManyRelationship[1];
                [[@(child1.primaryKey) should] equal:@11];

                [[@([UniqueToManyChildRealmObject allObjectsInRealm:realm].count) should] equal:@2];
            });

            it(@"should replace values", ^{
                NSDictionary *fixture1 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyUpdate"];
                [deserializer fillObject:object fromRepresentation:fixture1 mapping:mapping];

                [[@(object.primaryKey) should] equal:@5];
                [[@(object.toManyRelationship.count) should] equal:@2];

                UniqueToManyChildRealmObject *child0 = object.toManyRelationship[0];
                [[@(child0.primaryKey) should] equal:@11];
                UniqueToManyChildRealmObject *child1 = object.toManyRelationship[1];
                [[@(child1.primaryKey) should] equal:@12];

                [[@([UniqueToManyChildRealmObject allObjectsInRealm:realm].count) should] equal:@2];
                [[@([UniqueToManyChildRealmObject objectsInRealm:realm where:@"primaryKey == 10"].count) should] beZero];
            });

            it(@"should replace by null value", ^{
                NSDictionary *fixture2 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyNull"];
                [deserializer fillObject:object fromRepresentation:fixture2 mapping:mapping];

                [[@(object.primaryKey) should] equal:@5];
                [[@(object.toManyRelationship.count) should] equal:@0];

                [[@([UniqueToManyChildRealmObject allObjectsInRealm:realm].count) should] equal:@0];
            });

            it(@"should replace by empty array", ^{
                NSDictionary *fixture3 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyEmptyArray"];
                [deserializer fillObject:object fromRepresentation:fixture3 mapping:mapping];

                [[@(object.primaryKey) should] equal:@5];
                [[@(object.toManyRelationship.count) should] equal:@0];

                [[@([UniqueToManyChildRealmObject allObjectsInRealm:realm].count) should] equal:@0];
            });
        });
    });
});

SPEC_END
