// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

#import <Kiwi/Kiwi.h>
#import <FastEasyMapping/FastEasyMapping.h>
#import <FastEasyMappingRealm/FastEasyMappingRealm.h>
#import <Realm/Realm.h>
#import <Realm/RLMRealm_Dynamic.h>

#import "ObjCObject.h"
#import "UniqueObject.h"
#import "FEMRealmAssignmentPolicy.h"
#import "Fixture.h"
#import "UniqueChildObject.h"

SPEC_BEGIN(FEMAssignmentPolicyCollectionSpec)
describe(@"FEMAssignmentPolicyCollection", ^{
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

    context(@"assign", ^{
        __block FEMMapping *mapping = nil;

        __block UniqueObject *object = nil;
        beforeEach(^{
            mapping = [UniqueObject toManyRelationshipMappingWithPolicy:FEMAssignmentPolicyAssign];
            NSDictionary *fixture0 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyInit"];
            object = [deserializer objectFromRepresentation:fixture0 mapping:mapping];
        });

        afterEach(^{
           [realm transactionWithBlock:^{
               [realm deleteAllObjects];
           }];
        });

        it(@"should assign value", ^{
            [[@(object.identifier) should] equal:@5];
            [[@(object.toManyRelationship.count) should] equal:@2];

            UniqueChildObject *child0 = object.toManyRelationship[0];
            [[@(child0.identifier) should] equal:@10];
            UniqueChildObject *child1 = object.toManyRelationship[1];
            [[@(child1.identifier) should] equal:@11];
        });

        it(@"should re-assign value", ^{
            NSDictionary *fixture1 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyUpdate"];
            [deserializer fillObject:object fromRepresentation:fixture1 mapping:mapping];

            [[@(object.identifier) should] equal:@5];
            [[@(object.toManyRelationship.count) should] equal:@2];

            UniqueChildObject *child0 = object.toManyRelationship[0];
            [[@(child0.identifier) should] equal:@11];
            UniqueChildObject *child1 = object.toManyRelationship[1];
            [[@(child1.identifier) should] equal:@12];

            [[@([UniqueChildObject allObjectsInRealm:realm].count) should] equal:@3];
            [[@([UniqueChildObject objectsInRealm:realm where:@"identifier == 10"].count) shouldNot] beZero];
        });

        it(@"should assign null", ^{
            NSDictionary *fixture2 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyNull"];
            [deserializer fillObject:object fromRepresentation:fixture2 mapping:mapping];

            [[@(object.identifier) should] equal:@5];
            [[@(object.toManyRelationship.count) should] equal:@0];

            [[@([UniqueChildObject allObjectsInRealm:realm].count) should] equal:@2];
            [[@([UniqueChildObject objectsInRealm:realm where:@"identifier == 10"].count) shouldNot] beZero];
            [[@([UniqueChildObject objectsInRealm:realm where:@"identifier == 11"].count) shouldNot] beZero];
        });
    });

    context(@"merge", ^{
        FEMMapping *mapping = [UniqueObject toManyRelationshipMappingWithPolicy:FEMRealmAssignmentPolicyCollectionMerge];

        __block UniqueObject *object = nil;
        beforeEach(^{
            NSDictionary *fixture0 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyInit"];
            object = [deserializer objectFromRepresentation:fixture0 mapping:mapping];
        });

        afterEach(^{
            [realm transactionWithBlock:^{
                [realm deleteAllObjects];
            }];
        });

        it(@"should assign value", ^{
            [[@(object.identifier) should] equal:@5];
            [[@(object.toManyRelationship.count) should] equal:@2];

            UniqueChildObject *child0 = object.toManyRelationship[0];
            [[@(child0.identifier) should] equal:@10];
            UniqueChildObject *child1 = object.toManyRelationship[1];
            [[@(child1.identifier) should] equal:@11];

            [[@([UniqueChildObject allObjectsInRealm:realm].count) should] equal:@2];
        });

        it(@"should merge values", ^{
            NSDictionary *fixture1 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyUpdate"];
            [deserializer fillObject:object fromRepresentation:fixture1 mapping:mapping];

            [[@(object.identifier) should] equal:@5];
            [[@(object.toManyRelationship.count) should] equal:@3];

            UniqueChildObject *child0 = object.toManyRelationship[0];
            [[@(child0.identifier) should] equal:@10];
            UniqueChildObject *child1 = object.toManyRelationship[1];
            [[@(child1.identifier) should] equal:@11];
            UniqueChildObject *child2 = object.toManyRelationship[2];
            [[@(child2.identifier) should] equal:@12];

            [[@([UniqueChildObject allObjectsInRealm:realm].count) should] equal:@3];
        });

        it(@"should ignore null value", ^{
            NSDictionary *fixture2 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyNull"];
            [deserializer fillObject:object fromRepresentation:fixture2 mapping:mapping];

            [[@(object.identifier) should] equal:@5];
            [[@(object.toManyRelationship.count) should] equal:@2];

            UniqueChildObject *child0 = object.toManyRelationship[0];
            [[@(child0.identifier) should] equal:@10];
            UniqueChildObject *child1 = object.toManyRelationship[1];
            [[@(child1.identifier) should] equal:@11];

            [[@([UniqueChildObject allObjectsInRealm:realm].count) should] equal:@2];
        });

        it(@"should ignore empty array", ^{
            NSDictionary *fixture3 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyEmptyArray"];
            [deserializer fillObject:object fromRepresentation:fixture3 mapping:mapping];

            [[@(object.identifier) should] equal:@5];
            [[@(object.toManyRelationship.count) should] equal:@2];

            UniqueChildObject *child0 = object.toManyRelationship[0];
            [[@(child0.identifier) should] equal:@10];
            UniqueChildObject *child1 = object.toManyRelationship[1];
            [[@(child1.identifier) should] equal:@11];

            [[@([UniqueChildObject allObjectsInRealm:realm].count) should] equal:@2];
        });
    });

    context(@"replace", ^{
        FEMMapping *mapping = [UniqueObject toManyRelationshipMappingWithPolicy:FEMRealmAssignmentPolicyCollectionReplace];

        __block UniqueObject *object = nil;
        beforeEach(^{
            NSDictionary *fixture0 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyInit"];
            object = [deserializer objectFromRepresentation:fixture0 mapping:mapping];
        });

        afterEach(^{
            [realm transactionWithBlock:^{
                [realm deleteAllObjects];
            }];
        });

        it(@"should assign value", ^{
            [[@(object.identifier) should] equal:@5];
            [[@(object.toManyRelationship.count) should] equal:@2];

            UniqueChildObject *child0 = object.toManyRelationship[0];
            [[@(child0.identifier) should] equal:@10];
            UniqueChildObject *child1 = object.toManyRelationship[1];
            [[@(child1.identifier) should] equal:@11];

            [[@([UniqueChildObject allObjectsInRealm:realm].count) should] equal:@2];
        });

        it(@"should replace values", ^{
            NSDictionary *fixture1 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyUpdate"];
            [deserializer fillObject:object fromRepresentation:fixture1 mapping:mapping];

            [[@(object.identifier) should] equal:@5];
            [[@(object.toManyRelationship.count) should] equal:@2];

            UniqueChildObject *child0 = object.toManyRelationship[0];
            [[@(child0.identifier) should] equal:@11];
            UniqueChildObject *child1 = object.toManyRelationship[1];
            [[@(child1.identifier) should] equal:@12];

            [[@([UniqueChildObject allObjectsInRealm:realm].count) should] equal:@2];
            [[@([UniqueChildObject objectsInRealm:realm where:@"identifier == 10"].count) should] beZero];
        });

        it(@"should replace by null value", ^{
            NSDictionary *fixture2 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyNull"];
            [deserializer fillObject:object fromRepresentation:fixture2 mapping:mapping];

            [[@(object.identifier) should] equal:@5];
            [[@(object.toManyRelationship.count) should] equal:@0];

            [[@([UniqueChildObject allObjectsInRealm:realm].count) should] equal:@0];
        });

        it(@"should replace by empty array", ^{
            NSDictionary *fixture3 = [Fixture buildUsingFixture:@"AssignmentPolicyToManyEmptyArray"];
            [deserializer fillObject:object fromRepresentation:fixture3 mapping:mapping];

            [[@(object.identifier) should] equal:@5];
            [[@(object.toManyRelationship.count) should] equal:@0];

            [[@([UniqueChildObject allObjectsInRealm:realm].count) should] equal:@0];
        });
    });
});

SPEC_END
