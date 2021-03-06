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

SPEC_BEGIN(FEMAssignmentPolicyObjectSpec)
describe(@"FEMAssignmentPolicyObject", ^{
    __block RLMRealm *realm = nil;
    __block FEMRealmStore *store = nil;
    __block FEMDeserializer *deserializer = nil;

    __block UniqueObject *object;
    __block UniqueChildObject *child;

    beforeEach(^{
        RLMRealmConfiguration *configuration = [[RLMRealmConfiguration alloc] init];
        configuration.inMemoryIdentifier = @"assignment_policy_tests";
        realm = [RLMRealm realmWithConfiguration:configuration error:nil];

        store = [[FEMRealmStore alloc] initWithRealm:realm];
        deserializer = [[FEMDeserializer alloc] initWithStore:store];
    });

    afterEach(^{
        [realm transactionWithBlock:^{
            [realm deleteAllObjects];
        }];
        
        realm = nil;
        store = nil;
        deserializer = nil;
        object = nil;
        child = nil;
    });

    // We re-test built-in policies to make sure that Realm works as expected

    context(@"assign", ^{
        FEMMapping *mapping = [UniqueObject toOneRelationshipMappingWithPolicy:FEMAssignmentPolicyAssign];

        context(@"when old value null", ^{
            beforeEach(^{
                NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneNull"];
                object = [deserializer objectFromRepresentation:fixture mapping:mapping];
            });

            context(@"new value nonnull", ^{
                beforeEach(^{
                    NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneInit"];
                    [deserializer fillObject:object fromRepresentation:fixture mapping:mapping];
                });

                it(@"should assign new value", ^{
                    [[object.toOneRelationship shouldNot] beNil];
                    [[theValue(object.toOneRelationship.identifier) should] equal:theValue(10)];
                    [[theValue([realm allObjects:[UniqueChildObject className]].count) should] equal:theValue(1)];
                });
            });
        });

        context(@"when old value nonnull", ^{
            beforeEach(^{
                NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneInit"];
                object = [deserializer objectFromRepresentation:fixture mapping:mapping];
                child = object.toOneRelationship;
            });

            context(@"new value nonnull", ^{
                beforeEach(^{
                    NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneUpdate"];
                    [deserializer fillObject:object fromRepresentation:fixture mapping:mapping];
                });

                it(@"should assign new value", ^{
                    [[object.toOneRelationship shouldNot] beNil];
                    [[theValue(object.toOneRelationship.identifier) should] equal:theValue(11)];
                });

                it(@"shouldn't remove old value", ^{
                    [[theValue(child.invalidated) should] beFalse];
                    [[child.realm should] equal:realm];

                    [[[realm objectWithClassName:[UniqueChildObject className] forPrimaryKey:@(10)] should] equal:child];
                    [[theValue([realm allObjects:[UniqueChildObject className]].count) should] equal:theValue(2)];
                });
            });

            context(@"new value null", ^{
                beforeEach(^{
                    NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneNull"];
                    [deserializer fillObject:object fromRepresentation:fixture mapping:mapping];
                });

                it(@"should assign null", ^{
                    [[object.toOneRelationship should] beNil];
                });

                it(@"shouldn't remove old value", ^{
                    [[theValue(child.invalidated) should] beFalse];
                    [[child.realm should] equal:realm];

                    [[[realm objectWithClassName:[UniqueChildObject className] forPrimaryKey:@(10)] should] equal:child];
                    [[theValue([realm allObjects:[UniqueChildObject className]].count) should] equal:theValue(1)];
                });
            });
        });
    });

    context(@"merge", ^{
        FEMMapping *mapping = [UniqueObject toOneRelationshipMappingWithPolicy:FEMAssignmentPolicyObjectMerge];

        context(@"when old value null", ^{
            beforeEach(^{
                NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneNull"];
                object = [deserializer objectFromRepresentation:fixture mapping:mapping];
            });

            context(@"new value nonnull", ^{
                beforeEach(^{
                    NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneInit"];
                    [deserializer fillObject:object fromRepresentation:fixture mapping:mapping];
                });

                it(@"should assign new value", ^{
                    [[object.toOneRelationship shouldNot] beNil];
                    [[theValue(object.toOneRelationship.identifier) should] equal:theValue(10)];
                    [[theValue([realm allObjects:[UniqueChildObject className]].count) should] equal:theValue(1)];
                });
            });
        });

        context(@"when old value nonnull", ^{
            beforeEach(^{
                NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneInit"];
                object = [deserializer objectFromRepresentation:fixture mapping:mapping];
                child = object.toOneRelationship;
            });

            context(@"new value nonnull", ^{
                beforeEach(^{
                    NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneUpdate"];
                    [deserializer fillObject:object fromRepresentation:fixture mapping:mapping];
                });

                it(@"should assign new value", ^{
                    [[object.toOneRelationship shouldNot] beNil];
                    [[theValue(object.toOneRelationship.identifier) should] equal:theValue(11)];
                });

                it(@"shouldn't remove old value", ^{
                    [[theValue(child.invalidated) should] beFalse];
                    [[child.realm should] equal:realm];

                    [[[realm objectWithClassName:[UniqueChildObject className] forPrimaryKey:@(10)] should] equal:child];
                    [[theValue([realm allObjects:[UniqueChildObject className]].count) should] equal:theValue(2)];
                });
            });

            context(@"new value null", ^{
                beforeEach(^{
                    NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneNull"];
                    [deserializer fillObject:object fromRepresentation:fixture mapping:mapping];
                });

                it(@"should preserve old value", ^{
                    [[object.toOneRelationship shouldNot] beNil];
                    [[theValue(object.toOneRelationship.identifier) should] equal:theValue(10)];
                    [[theValue([realm allObjects:[UniqueChildObject className]].count) should] equal:theValue(1)];
                });
            });
        });
    });

    context(@"replace", ^{
        FEMMapping *mapping = [UniqueObject toOneRelationshipMappingWithPolicy:FEMAssignmentPolicyObjectReplace];

        context(@"when old value null", ^{
            beforeEach(^{
                NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneNull"];
                object = [deserializer objectFromRepresentation:fixture mapping:mapping];
            });

            context(@"new value nonnull", ^{
                beforeEach(^{
                    NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneInit"];
                    [deserializer fillObject:object fromRepresentation:fixture mapping:mapping];
                });

                it(@"should assign new value", ^{
                    [[object.toOneRelationship shouldNot] beNil];
                    [[theValue(object.toOneRelationship.identifier) should] equal:theValue(10)];
                    [[theValue([realm allObjects:[UniqueChildObject className]].count) should] equal:theValue(1)];
                });
            });
        });

        context(@"when old value nonnull", ^{
            beforeEach(^{
                NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneInit"];
                object = [deserializer objectFromRepresentation:fixture mapping:mapping];
                child = object.toOneRelationship;
            });

            context(@"new value nonnull", ^{
                beforeEach(^{
                    NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneUpdate"];
                    [deserializer fillObject:object fromRepresentation:fixture mapping:mapping];
                });

                it(@"should assign new value", ^{
                    [[object.toOneRelationship shouldNot] beNil];
                    [[theValue(object.toOneRelationship.identifier) should] equal:theValue(11)];
                });

                it(@"should remove old value", ^{
                    [[theValue(child.invalidated) should] beTrue];

                    [[[realm objectWithClassName:[UniqueChildObject className] forPrimaryKey:@(10)] should] beNil];
                    [[theValue([realm allObjects:[UniqueChildObject className]].count) should] equal:theValue(1)];
                });
            });

            context(@"new value null", ^{
                beforeEach(^{
                    NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneNull"];
                    [deserializer fillObject:object fromRepresentation:fixture mapping:mapping];
                });

                it(@"should assign null", ^{
                    [[object.toOneRelationship should] beNil];
                });

                it(@"should remove old value", ^{
                    [[theValue(child.invalidated) should] beTrue];

                    [[[realm objectWithClassName:[UniqueChildObject className] forPrimaryKey:@(10)] should] beNil];
                    [[theValue([realm allObjects:[UniqueChildObject className]].count) should] equal:theValue(0)];
                });
            });
        });
    });
});

SPEC_END
