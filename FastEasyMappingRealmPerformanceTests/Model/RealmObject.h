
@import Foundation;
@import Realm;

@interface RealmObject : RLMObject

@property (nonatomic) BOOL boolValue;
@property (nonatomic, nullable) NSNumber<RLMBool> *boolObject;

@property (nonatomic) int intValue;
@property (nonatomic, nullable) NSNumber<RLMInt> *intObject;

@property (nonatomic) NSInteger nsIntegerValue;
@property (nonatomic, nullable) NSNumber<RLMInt> *nsIntegerObject;

@property (nonatomic) long longValue;
@property (nonatomic, nullable) NSNumber<RLMInt> *longObject;

@property (nonatomic) long long longLongValue;
@property (nonatomic, nullable) NSNumber<RLMInt> *longLongObject;

@property (nonatomic) float floatValue;
@property (nonatomic, nullable) NSNumber<RLMFloat> *floatObject;

@property (nonatomic) double doubleValue;
@property (nonatomic, nullable) NSNumber<RLMDouble> *doubleObject;

@property (nonatomic, copy, nullable) NSString *string;
@property (nonatomic, strong, nullable) NSDate *date;
@property (nonatomic, strong, nullable) NSData *data;

@property (nonatomic, strong, nullable) ChildRealmObject *toOneRelationship;
@property RLMArray<ChildRealmObject> *toManyRelationship;

@end

@interface RealmObject (Mapping)

+ (FEMMapping *)defaultMapping;

@end