// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

import Quick
import Nimble
import FastEasyMappingRealm
import RealmSwift

class AssignmentPolicyCollectionSpec: QuickSpec {
  
  override func spec() {
    describe("mapping") {
      var realm: Realm!
      var deserializer: FEMDeserializer!
      var store: FEMRealmStore!
      
      var object: SwiftUniqueObject!
      
      beforeEach {
        let configuration = Realm.Configuration(inMemoryIdentifier: "tests")
        realm = try! Realm(configuration: configuration)
        store = FEMRealmStore(realm: ObjectiveCSupport.convert(object: realm))
        deserializer = FEMDeserializer(store: store)
      }
      
      afterEach {
        try! realm.write {
          realm.deleteAll()
        }
      }
      
      context("assign") {
        let mapping = SwiftUniqueObject.toManyRelationshipMapping(with: FEMAssignmentPolicyAssign)
        
        context("when old value null") {
          beforeEach {
            let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyNull")!
            object = deserializer.object(fromRepresentation: fixture, mapping: mapping) as! SwiftUniqueObject
          }
          
          context("new value nonnull") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyInit")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign value") {
              expect(object.toManyRelationship[0].identifier) == 10
              expect(object.toManyRelationship[1].identifier) == 11
            }
          }
        }
        
        context("when old value nonnull") {
          beforeEach {
            let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyInit")!
            object = deserializer.object(fromRepresentation: fixture, mapping: mapping) as! SwiftUniqueObject
          }
          
          context("new value null") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyNull")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign nil") {
              expect(object.toManyRelationship.count) == 0
            }
            
            it("should preserve old values") {
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 2
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 10)).toNot(beNil())
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 11)).toNot(beNil())
            }
          }
          
          context("new value nonnull") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyUpdate")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign value") {
              expect(object.toManyRelationship[0].identifier) == 11
              expect(object.toManyRelationship[1].identifier) == 12
            }
            
            it("should preserve old values") {
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 3
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 10)).toNot(beNil())
            }
          }
        }
      }
      
      context("merge") {
        let mapping = SwiftUniqueObject.toManyRelationshipMapping(with: FEMRealmAssignmentPolicyCollectionMerge)
        
        context("when old value null") {
          beforeEach {
            let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyNull")!
            object = deserializer.object(fromRepresentation: fixture, mapping: mapping) as! SwiftUniqueObject
          }
          
          context("new value nonnull") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyInit")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign value") {
              expect(object.toManyRelationship[0].identifier) == 10
              expect(object.toManyRelationship[1].identifier) == 11
            }
          }
        }
        
        context("when old value nonnull") {
          beforeEach {
            let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyInit")!
            object = deserializer.object(fromRepresentation: fixture, mapping: mapping) as! SwiftUniqueObject
          }
          
          context("new value null") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyNull")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign merged collection") {
              expect(object.toManyRelationship.count) == 2
              expect(object.toManyRelationship[0].identifier) == 10
              expect(object.toManyRelationship[1].identifier) == 11
            }
            
            it("should preserve existing values") {
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 2
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 10)).toNot(beNil())
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 11)).toNot(beNil())
            }
          }
          
          context("new value empty") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyEmptyArray")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign merged collection") {
              expect(object.toManyRelationship.count) == 2
              expect(object.toManyRelationship[0].identifier) == 10
              expect(object.toManyRelationship[1].identifier) == 11
            }
            
            it("should preserve existing values") {
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 2
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 10)).toNot(beNil())
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 11)).toNot(beNil())
            }
          }
          
          context("new value nonnull") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyUpdate")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign merged value") {
              expect(object.toManyRelationship.count) == 3

              expect(object.toManyRelationship[0].identifier) == 10
              expect(object.toManyRelationship[1].identifier) == 11
              expect(object.toManyRelationship[2].identifier) == 12
              
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 10)).toNot(beNil())
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 11)).toNot(beNil())
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 12)).toNot(beNil())
            }
          }
        }
      }
      
      context("replace") {
        let mapping = SwiftUniqueObject.toManyRelationshipMapping(with: FEMRealmAssignmentPolicyCollectionReplace)
        
        context("when old value null") {
          beforeEach {
            let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyNull")!
            object = deserializer.object(fromRepresentation: fixture, mapping: mapping) as! SwiftUniqueObject
          }
          
          context("new value nonnull") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyInit")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign value") {
              expect(object.toManyRelationship[0].identifier) == 10
              expect(object.toManyRelationship[1].identifier) == 11
            }
          }
        }
        
        context("when old value nonnull") {
          beforeEach {
            let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyInit")!
            object = deserializer.object(fromRepresentation: fixture, mapping: mapping) as! SwiftUniqueObject
          }
          
          context("new value null") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyNull")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign empty collection") {
              expect(object.toManyRelationship.count) == 0
            }
            
            it("should remove old values") {
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 0
            }
          }
          
          context("new value empty") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyEmptyArray")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign empty collection") {
              expect(object.toManyRelationship.count) == 0
            }
            
            it("should remove old values") {
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 0
            }
          }
          
          context("new value nonnull") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToManyUpdate")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign new value") {
              expect(object.toManyRelationship.count) == 2
              expect(object.toManyRelationship[0].identifier) == 11
              expect(object.toManyRelationship[1].identifier) == 12
            }
            
            it("should remove old values") {
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 2
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 10)).to(beNil())
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 11)).toNot(beNil())
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 12)).toNot(beNil())
            }
          }
        }
      }
    }
  }
}
