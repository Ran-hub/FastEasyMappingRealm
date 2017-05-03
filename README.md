# [WIP] FastEasyMappingRealm
- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
  - [Assignment Policies](#assignment-policies)
  - [Swift](#swift)

## Overview
FastEasyMappingRealm is an extension to the [FastEasyMapping](https://github.com/Yalantis/FastEasyMapping) that allows you to map [Realm](https://github.com/realm/realm-cocoa) objects from (and to) the JSON. Supports both **Realm** and **RealmSwift**. 

## Features
- Common mapping features such as keys or/and values transformation
- Assignment policies that gives you ability to assign (default), merge or even replace values of the relationship with zero effort
- Recursive relationships support
- Mapping is a separate entity and doesn't lock your DTO to a single JSON representation
- Finegrained control over mapping process via delegation
- Unified code for NSObject/CoreData/Realm mappings

## Requirements
Platform | Min Deployment Target
:---: | :---:
iOS | 8.0
macOS | 10.10
tvOS | 9.0
watchOS | 2.0

Build using Xcode 8.3.2+

## Installation
### CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'FastEasyMappingRealm', '~> 1.0'
  
    # Realm will be grabbed as a dependency, but you may want to specify it manually 
    # pod 'Realm', '~> 2.7'
    # pod 'RealmSwift', '~> 2.7'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate FastEasyMappingRealm into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "Yalantis/FastEasyMappingRealm" ~> 1.0

# Realm will be grabbed as a dependency, but you may want to specify it manually 
github "realm/realm-cocoa" ~> 2.7
```

Run `carthage update` to build the framework and drag the built `FastEasyMappingRealm.framework`, `FastEasyMapping.framework`, `Realm.framework` and (optionally) `RealmSwift.framework` into your Xcode project. 

## Usage
### Getting started
In order to start using FEM you have to describe `FEMMapping` instance:
###### Objective-C
```objective-c
FEMMapping *userMapping = [[FEMMapping alloc] initWithObjectClass:[RealmUser class]];
userMapping.primaryKey = [RelamUser primaryKey];
[userMapping addAttributesFromDictionary:@{@"userID": @"user_id", @"username": @"user_email"}]; 

// later in code

// map single Realm Object
RealmUser *user = [FEMDeserializer objectFromRepresentation:userJSON mapping:userMapping realm:realm];

// map list of Realm Objects
NSArray *users = [FEMDeserializer collectionFromRepresentation:JSONWithUsers mapping:userMapping realm:realm];

// update existing Realm Object
[FEMDeserializer fillObject:existingUser fromRepresentation:userJSON mapping:userMapping realm:realm];
```

###### Swift
```swift
let userMapping = FEMMapping(objectClass: RealmUser.self)
userMapping.primaryKey = RealmUser.primaryKey()

let realm = ObjectiveCSupport.convert(object: swiftRealm) // to convert to the RLMRealm

// map single Realm Object
let user = FEMDeserializer.object(from: userJSON, mapping: userMapping, realm: realm) as! RealmUser

// map list of Realm Objects
let users = FEMDeserializer.collection(from: usersJSON, mapping: userMapping, realm: realm) as! [RealmUser]

// update existing Realm Object
FEMDeserializer.fill(object: existingUser, from: userJSON, mapping: userMapping, realm: realm)
```

### Relationships
FastEasyMappingRealm supports relationships as well. Both to-one and to-many. For example imagine a following scheme where `User` has a to-many relationship with a `Comment` object: 

###### Objective-C
```objective-c
FEMMapping *userMapping = [[FEMMapping alloc] initWithObjectClass:[User class]];
// same code as above 

FEMMapping *commentMapping = [[FEMMapping alloc] initWithObjectClass:[Comment class]];
commentMapping.primaryKey = [Comment primaryKey];
[commentMapping addAttributesFromArray:@[@"uniqueID", @"content"]]; 

[userMapping addToManyRelationshipMapping:commentMapping forProperty:@"comments" keyPath:@"user_comments"];
```

###### Swift
```swift
let userMapping = FEMMapping(objectClass: User.self)
// same code as above 

let commentMapping = FEMMapping(objectClass: Comment.self)
commentMapping.primaryKey = Comment.primaryKey()
commentMapping.addAttributes(from: ["uniqueID", "content"])

userMapping.addToManyRelationshipMapping(commentMapping, forProperty: "comments" keyPath: "user_comments")
```

What if we want to update `User` comments and to remove old one automatically to not populate realm with dangling `Comments`? Then we have to use a `FEMRealmAssignmentPolicyCollectionReplace` (or `FEMRealmAssignmentPolicyCollectionMerge` for merge correspondingly): 
###### Objective-C
```objective-c
FEMMapping *userMapping = [[FEMMapping alloc] initWithObjectClass:[User class]];
// same code as above 

FEMMapping *commentMapping = [[FEMMapping alloc] initWithObjectClass:[Comment class]];
// same code as above 

FEMRelationship *commentsRelationship = [[FEMRelationship alloc] initWithProperty:@"comments" keyPath:@"user_comments" mapping:commentMapping];
commentsRelationship.assignmentPolicy = FEMRealmAssignmentPolicyCollectionReplace;
commentsRelationship.toMany = YES;

[userMapping addRelationship:commentsRelationship];
```

###### Swift
```swift
let userMapping = FEMMapping(objectClass: User.self)
// same code as above 

let commentMapping = FEMMapping(objectClass: Comment.self)
// same code as above 

let commentsRelationship = FEMRelationship(property: "comments", keyPath: "user_comments", mapping: commentMapping)
commentsRelationship.assignmentPolicy = FEMRealmAssignmentPolicyCollectionReplace
commentsRelationship.toMany = true

userMapping.addRelationship(commentsRelationship)
```

For the comprehensive usage guide please visit [FastEasyMapping](https://github.com/Yalantis/FastEasyMapping) page.

### Assignment Policies
Quite often during relationship mapping we're doing an update and not a simple assignment. After update it is useful to remove "old" values of the relationship that are no longer in use. FastEasyMapping offers an elegan and simple solution by exposing a customization point. Built-in assignment policies are: 

##### To-one relationship
Desired action | Policy | Description
:---: | :---: | :---:
Assign | FEMAssignmentPolicyAssign | Assign new value. Previous value stays in the database untouched
Merge | FEMAssignmentPolicyObjectMerge | Pick either a new or old value depending on which one presented. Previous value stays in the database untouched
Replace | FEMAssignmentPolicyObjectReplace | Replace old values by new. Previous values removed

##### To-many relationship
Desired action | Policy | Description
:---: | :---: | :---:
Assign | FEMAssignmentPolicyAssign | Assign new value. Previous value stays in the database untouched
Merge | FEMRealmAssignmentPolicyCollectionMerge | Merge two collections. Previos value included in the new one
Replace | FEMRealmAssignmentPolicyCollectionReplace | Replace old values by new. Values not presented in the new collection removed from the database

For the comprehensive usage guide please visit [FastEasyMapping: Assignment Policy](https://github.com/Yalantis/FastEasyMapping#assignment-policy) page.

### Swift
