// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Kiwi/Kiwi.h>
#import <FastEasyMapping/FastEasyMapping.h>
#import <FastEasyMappingRealm/FastEasyMappingRealm.h>
#import <Realm/Realm.h>
#import <Realm/RLMRealm_Dynamic.h>

#import "RealmObject.h"
#import "UniqueRealmObject.h"
#import "UniqueToManyChildRealmObject.h"
#import "FEMRealmAssignmentPolicy.h"
#import "Fixture.h"
#import "UniqueChildRealmObject.h"

SPEC_BEGIN(FEMAssignmentPolicyObjectSpec)
describe(@"FEMAssignmentPolicyObject", ^{
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

    // We re-test built-in policies to make sure that Realm works as expected

    __block UniqueRealmObject *object;
    __block UniqueChildRealmObject *child;

    afterEach(^{
        object = nil;
        child = nil;
    });

    context(@"assign", ^{
        FEMMapping *mapping = [UniqueRealmObject toManyRelationshipMappingWithPolicy:FEMAssignmentPolicyAssign];

        beforeEach(^{
            NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneInit"];
            object = [deserializer objectFromRepresentation:fixture mapping:mapping];
            child = object.toOneRelationship;
        });

        context(@"init", ^{
            it(@"should assign new value", ^{
                [[@(object.primaryKey) should] equal:@5];

                [[object.toOneRelationship shouldNot] beNil];
                [[theValue(object.toOneRelationship.primaryKey) should] equal:theValue(10)];
                [[theValue([realm allObjects:[UniqueChildRealmObject className]].count) should] equal:theValue(1)];
            });
        });

        context(@"update", ^{
            beforeEach(^{
                NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneUpdate"];
                [deserializer fillObject:object fromRepresentation:fixture mapping:mapping];
            });

            it(@"should assign new value", ^{
                [[object.toOneRelationship shouldNot] beNil];
                [[theValue(object.toOneRelationship.primaryKey) should] equal:theValue(11)];
            });

            it(@"shouldn't remove old value", ^{
                [[theValue(child.invalidated) should] beFalse];
                [[child.realm should] equal:realm];

                [[[realm objectWithClassName:[UniqueChildRealmObject className] forPrimaryKey:@(10)] should] equal:child];
                [[theValue([realm allObjects:[UniqueChildRealmObject className]].count) should] equal:theValue(2)];
            });
        });

        context(@"nullifying", ^{
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

                [[[realm objectWithClassName:[UniqueChildRealmObject className] forPrimaryKey:@(10)] should] equal:child];
                [[theValue([realm allObjects:[UniqueChildRealmObject className]].count) should] equal:theValue(1)];
            });
        });
    });

    context(@"merge", ^{
        FEMMapping *mapping = [UniqueRealmObject toManyRelationshipMappingWithPolicy:FEMAssignmentPolicyObjectMerge];

        beforeEach(^{
            NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneInit"];
            object = [deserializer objectFromRepresentation:fixture mapping:mapping];
            child = object.toOneRelationship;
        });

        context(@"init", ^{
            it(@"should assign new value", ^{
                [[object.toOneRelationship shouldNot] beNil];
                [[theValue(object.toOneRelationship.primaryKey) should] equal:theValue(10)];
                [[theValue([realm allObjects:[UniqueChildRealmObject className]].count) should] equal:theValue(1)];
            });
        });

        context(@"update", ^{
            beforeEach(^{
                NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneUpdate"];
                [deserializer fillObject:object fromRepresentation:fixture mapping:mapping];
            });

            it(@"should assign new value", ^{
                [[object.toOneRelationship shouldNot] beNil];
                [[theValue(object.toOneRelationship.primaryKey) should] equal:theValue(11)];
            });

            it(@"shouldn't remove old value", ^{
                [[theValue(child.invalidated) should] beFalse];
                [[child.realm should] equal:realm];

                [[[realm objectWithClassName:[UniqueChildRealmObject className] forPrimaryKey:@(10)] should] equal:child];
                [[theValue([realm allObjects:[UniqueChildRealmObject className]].count) should] equal:theValue(2)];
            });
        });

        context(@"nullifying", ^{
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

                [[[realm objectWithClassName:[UniqueChildRealmObject className] forPrimaryKey:@(10)] should] equal:child];
                [[theValue([realm allObjects:[UniqueChildRealmObject className]].count) should] equal:theValue(1)];
            });
        });
    });

    context(@"replace", ^{
        FEMMapping *mapping = [UniqueRealmObject toManyRelationshipMappingWithPolicy:FEMAssignmentPolicyObjectReplace];

        beforeEach(^{
            NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneInit"];
            object = [deserializer objectFromRepresentation:fixture mapping:mapping];
            child = object.toOneRelationship;
        });

        context(@"init", ^{
            it(@"should assign new value", ^{
                [[@(object.primaryKey) should] equal:@5];

                [[object.toOneRelationship shouldNot] beNil];
                [[theValue(object.toOneRelationship.primaryKey) should] equal:theValue(10)];
                [[theValue([realm allObjects:[UniqueChildRealmObject className]].count) should] equal:theValue(1)];
            });
        });

        context(@"update", ^{
            beforeEach(^{
                NSDictionary *fixture = [Fixture buildUsingFixture:@"AssignmentPolicyToOneUpdate"];
                [deserializer fillObject:object fromRepresentation:fixture mapping:mapping];
            });

            it(@"should assign new value", ^{
                [[object.toOneRelationship shouldNot] beNil];
                [[theValue(object.toOneRelationship.primaryKey) should] equal:theValue(11)];
            });

            it(@"shouldn't remove old value", ^{
                [[theValue(child.invalidated) should] beFalse];
                [[child.realm should] equal:realm];

                [[[realm objectWithClassName:[UniqueChildRealmObject className] forPrimaryKey:@(10)] should] equal:child];
                [[theValue([realm allObjects:[UniqueChildRealmObject className]].count) should] equal:theValue(2)];
            });
        });

        context(@"nullifying", ^{
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

                [[[realm objectWithClassName:[UniqueChildRealmObject className] forPrimaryKey:@(10)] should] equal:child];
                [[theValue([realm allObjects:[UniqueChildRealmObject className]].count) should] equal:theValue(1)];
            });
        });
    });

});

SPEC_END
