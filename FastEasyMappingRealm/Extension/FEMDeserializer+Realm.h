// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

@import Foundation;
@import FastEasyMapping;

@class RLMRealm;

NS_ASSUME_NONNULL_BEGIN

/**
 @brief Extension to `FEMDeserializer` for Realm support
 */
@interface FEMDeserializer (Realm)

/**
 @brief Initializes FEMDeserializer for mapping of Realm subclasses in a given `realm`. Convenience initializer.
 
 @discussion Same as initializing `FEMDeserializer` with `FEMRealmStore` instance with a given `realm`.
 
 IMPORTANT: Developer is responsible for deserializing objects on a `realm`s queue. FEM doesn't manage concurrency.
 
 @param realm Instance of RLMRealm to be used during deserialization. Use `ObjectiveCSupport.convert(object: realm)` to convert RealmSwift.Realm to RLMRealm.
 
 @return New instance of the FEMDeserializer.
 
 @see FEMRealmStore
 */
- (instancetype)initWithRealm:(RLMRealm *)realm;

/**
 @brief Deserialize NSManagedObject's subclass from the given `representation` by using `mapping`.
 
 @discussion Same as initializing `FEMDeserializer` with a `FEMRealmStore` and invoking -objectFromRepresentation:mapping:.
 
 @param representation Dictionary that representes object. Typically you get this value from the `-[NSJSONSerialization JSONObjectWithData:options:error:]` or similar.
 @param mapping Instance of `FEMMapping` used for the deserialization.
 @param realm Instance of RLMRealm to be used during deserialization. Use `ObjectiveCSupport.convert(object: realm)` to convert RealmSwift.Realm to RLMRealm.
 
 @return Deserialized instance of the type, specified by `mapping`.
 */
+ (id)objectFromRepresentation:(NSDictionary *)representation mapping:(FEMMapping *)mapping realm:(RLMRealm *)realm;

/**
 @brief Update given `object` by applying deserialized `representation` to it using `mapping`.
 
 @discussion Same as initializing `FEMDeserializer` with either a `FEMObjectStore` or `FEMManagedObjectStore` depending on the Object's class
 and invoking -fillObject:fromRepresentation:mapping:.
 
 @param object Realm's Object to which deserialized `representation` needs to be applied.
 @param representation Dictionary, representing JSON.
 @param mapping Instance of `FEMMapping` describing how `representation` needs to be applied to the `object`.
 @param realm Instance of RLMRealm to be used during deserialization. Use `ObjectiveCSupport.convert(object: realm)` to convert RealmSwift.Realm to RLMRealm.
 
 @return Same instance as passed to the `object`.
 */
+ (id)fillObject:(id)object fromRepresentation:(NSDictionary *)representation mapping:(FEMMapping *)mapping realm:(RLMRealm *)realm;

/**
 @brief Deserialize array of Realm's subclass from the given `representation` by using `mapping`.
 
 @discussion Same as initializing `FEMDeserializer` with a `FEMRealmStore` and invoking -collectionFromRepresentation:mapping:.
 
 @param representation Array that representes objects. Typically you get this value from the `-[NSJSONSerialization JSONObjectWithData:options:error:]` or similar.
 @param mapping Instance of `FEMMapping` used for the deserialization.
 @param realm Instance of RLMRealm to be used during deserialization. Use `ObjectiveCSupport.convert(object: realm)` to convert RealmSwift.Realm to RLMRealm.
 
 @return Array of deserialized instances of the type, specified by `mapping`.
 */
+ (NSArray *)collectionFromRepresentation:(NSArray *)representation mapping:(FEMMapping *)mapping realm:(RLMRealm *)realm;

@end

NS_ASSUME_NONNULL_END
