// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

@import FastEasyMapping.FEMAssignmentPolicy;

NS_ASSUME_NONNULL_BEGIN

/**
 @brief Merge two collections. Suitable for to-many relationship type.
 
 @discussion Given two collections: [A, B, C, D] and [1, 2, 3, 4]. Result of assignment is a merged collection: [A, B, C, D, 1, 2, 3, 4].
 Values that are presented in both collections do no duplicated, therefore merge of two collections [A, B] and [B, C] will result into a [A, B, C, D].
 
 Supported collections are:
 - For ObjC (with or without generics): NSArray, NSMutableArray, NSSet, NSMutableSet, NSOrderedSet, NSMutableOrderedSet.
 - For Swift: only bridgeable collections such as Array, Set. However you can also use plain ObjC collections (like NSOrderedSet) if needed.
 
 IMPORTANT: Designed only for to-many relationship type.
 */
OBJC_EXTERN FEMAssignmentPolicy FEMRealmAssignmentPolicyCollectionMerge;

/**
 @brief Replace old values by new. Suitable for to-many relationship type.
 
 @discussion Given two collections: [A, B, C, D] and [1, 2, 3, 4]. Result of assignment is a collection: [1, 2, 3, 4].
 Note, that [A, B, C, D] removed from the database!
 
 In case value presented in both new and old collections it . Therefore result of replacement of [A, B, C] by [C, D] is [C, D].
 [A, B] removed from the database!
 
 Supported collections are:
 - For ObjC (with or without generics): NSArray, NSMutableArray, NSSet, NSMutableSet, NSOrderedSet, NSMutableOrderedSet.
 - For Swift: only bridgeable collections such as Array, Set. However you can also use plain ObjC collections (like NSOrderedSet) if needed.
 
 IMPORTANT: Designed only for to-many relationship type.
 */
OBJC_EXTERN FEMAssignmentPolicy FEMRealmAssignmentPolicyCollectionReplace;

NS_ASSUME_NONNULL_END
