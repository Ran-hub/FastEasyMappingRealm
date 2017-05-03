// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

@import Kiwi;
@import FastEasyMapping;
@import FastEasyMappingRealm;
@import Realm;

#import "UniqueObject.h"

SPEC_BEGIN(FEMRealmStoreSpec)
describe(@"FEMRealmStore", ^{
    context(@"deserialization", ^{
        __block RLMRealm *realm = nil;
        __block FEMRealmStore *store = nil;

        beforeEach(^{
            RLMRealmConfiguration *configuration = [[RLMRealmConfiguration alloc] init];
            configuration.inMemoryIdentifier = @"tests";
            realm = [RLMRealm realmWithConfiguration:configuration error:nil];

            store = [[FEMRealmStore alloc] initWithRealm:realm];
        });

        afterEach(^{
            [realm transactionWithBlock:^{
                [realm deleteAllObjects];
            }];

            realm = nil;
            store = nil;
        });

        context(@"transaction", ^{
            it(@"should perform write transaction", ^{
                [[@(realm.inWriteTransaction) should] beFalse];
                [store beginTransaction:nil];
                [[@(realm.inWriteTransaction) should] beTrue];
                [store commitTransaction];
                [[@(realm.inWriteTransaction) should] beFalse];
            });
        });

        context(@"new object", ^{
            __block FEMMapping *mapping = nil;
            beforeAll(^{
                mapping = [[FEMMapping alloc] initWithObjectClass:[UniqueObject class]];
            });

            it(@"should create RLMObject specified in FEMMapping.entityName", ^{
                [store beginTransaction:nil];

                UniqueObject *object = [store newObjectForMapping:mapping];
                [[object should] beKindOfClass:[UniqueObject class]];

                [store commitTransaction];
            });

            it(@"should save new object after commit", ^{
                [store beginTransaction:nil];
                UniqueObject *object = [store newObjectForMapping:mapping];
                [store addObject:object forPrimaryKey:nil mapping:mapping];
                [store commitTransaction];

                [[@([UniqueObject allObjectsInRealm:realm].count) should] equal:@(1)];
            });
        });


        context(@"delete object", ^{
           it(@"should delete object as a delegate of assingment context", ^{
               [store beginTransaction:nil];

               FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[UniqueObject class]];
               UniqueObject *object = [store newObjectForMapping:mapping];
               FEMRelationshipAssignmentContext *context = [store newAssignmentContext];
               [context deleteRelationshipObject:object];

               [store commitTransaction];

               [[@([UniqueObject allObjectsInRealm:realm].count) should] equal:@(0)];
           });
        });

        context(@"add", ^{
            __block FEMMapping *mapping = nil;
            beforeEach(^{
                mapping = [UniqueObject defaultMapping];

                [store beginTransaction:nil];
            });

            afterEach(^{
                [store commitTransaction];
            });

            it(@"should add object with PK", ^{
                UniqueObject *object = [store newObjectForMapping:mapping];
                object.identifier = 5;

                [store addObject:object forPrimaryKey:@(object.identifier) mapping:mapping];
                
                [[[store objectForPrimaryKey:@(object.identifier) mapping:mapping] should] equal:object];
                [[[store objectForPrimaryKey:@(object.identifier + 1) mapping:mapping] should] beNil];
            });
        });

        context(@"prefetch", ^{
            __block FEMMapping *mapping = nil;
            beforeEach(^{
                mapping = [UniqueObject defaultMapping];
            });

            it(@"should automatically register existing objects", ^{
                __block UniqueObject *object = nil;
                [realm transactionWithBlock:^{
                    object = [[UniqueObject alloc] init];
                    object.identifier = 5;
                    [realm addObject:object];
                }];
                
                NSMapTable *presentedPrimaryKeys = [NSMapTable strongToStrongObjectsMapTable];
                [presentedPrimaryKeys setObject:[NSSet setWithObject:@5] forKey:mapping];
                
                [store beginTransaction:presentedPrimaryKeys];
                [[[store objectForPrimaryKey:@5 mapping:mapping] should] equal:object];
                [store commitTransaction];
            });
        });
    });
});

SPEC_END
