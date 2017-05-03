// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

import Quick
import Nimble
import FastEasyMappingRealm
import RealmSwift

class AssignmentPolicyObjectSpec: QuickSpec {
  
  override func spec() {
    describe("mapping") {
      var realm: Realm!
      var deserializer: FEMDeserializer!
      var store: FEMRealmStore!

      var object: SwiftUniqueObject!
      var child: SwiftUniqueChildObject!
    
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
      
      describe("assignment") {
        let mapping = SwiftUniqueObject.toOneRelationshipMapping(with: FEMAssignmentPolicyAssign)
        
        context("when old value null") {
          beforeEach {
            let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneNull")!
            object = deserializer.object(fromRepresentation: fixture, mapping: mapping) as! SwiftUniqueObject
          }
          
          context("new value nonnull") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneInit")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign new value") {
              expect(object.toOneRelationship).toNot(beNil())
              expect(object.toOneRelationship?.identifier) == 10
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 1
            }
          }
        }
        
        context("when old value nonnull") {
          beforeEach {
            let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneInit")!
            object = deserializer.object(fromRepresentation: fixture, mapping: mapping) as! SwiftUniqueObject
            child = object.toOneRelationship!
          }
          
          context("new value nonnull") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneUpdate")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign new value") {
              expect(object.toOneRelationship).toNot(beNil())
              expect(object.toOneRelationship?.identifier) == 11
            }
            
            it("shouldn't remove old value") {
              expect(child.isInvalidated) == false
              expect(child.realm) == realm
              
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 10)) == child
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 2
            }
          }
          
          context("new value null") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneNull")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign null") {
              expect(object.toOneRelationship).to(beNil())
            }
            
            it("shouldn't remove old value") {
              expect(child.isInvalidated) == false
              expect(child.realm) == realm
              
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 10)) == child
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 1
            }
          }
        }
      }
      
      describe("merge") {
        let mapping = SwiftUniqueObject.toOneRelationshipMapping(with: FEMAssignmentPolicyObjectMerge)
        
        context("when old value null") {
          beforeEach {
            let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneNull")!
            object = deserializer.object(fromRepresentation: fixture, mapping: mapping) as! SwiftUniqueObject
          }
          
          context("new value nonnull") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneInit")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign new value") {
              expect(object.toOneRelationship).toNot(beNil())
              expect(object.toOneRelationship?.identifier) == 10
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 1
            }
          }
        }
        
        context("when old value nonnull") {
          beforeEach {
            let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneInit")!
            object = deserializer.object(fromRepresentation: fixture, mapping: mapping) as! SwiftUniqueObject
            child = object.toOneRelationship!
          }

          context("new value nonnull") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneUpdate")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign new value") {
              expect(object.toOneRelationship).toNot(beNil())
              expect(object.toOneRelationship?.identifier) == 11
            }
            
            it("shouldn't remove old value") {
              expect(child.isInvalidated) == false
              expect(child.realm) == realm
              
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 10)) == child
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 2
            }
          }
          
          context("new value null") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneNull")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }

            it("should preserve old value") {
              expect(object.toOneRelationship).toNot(beNil())
              expect(object.toOneRelationship?.identifier) == 10
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 1
            }
          }
        }
      }
      
      describe("replace") {
        let mapping = SwiftUniqueObject.toOneRelationshipMapping(with: FEMAssignmentPolicyObjectReplace)

        context("when old value null") {
          beforeEach {
            let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneNull")!
            object = deserializer.object(fromRepresentation: fixture, mapping: mapping) as! SwiftUniqueObject
          }
          
          context("new value nonnull") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneInit")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign new value") {
              expect(object.toOneRelationship).toNot(beNil())
              expect(object.toOneRelationship?.identifier) == 10
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 1
            }
          }
        }
        
        context("when old value nonnull") {
          beforeEach {
            let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneInit")!
            object = deserializer.object(fromRepresentation: fixture, mapping: mapping) as! SwiftUniqueObject
            child = object.toOneRelationship!
          }
          
          context("new value nonnull") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneUpdate")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign new value") {
              expect(object.toOneRelationship).toNot(beNil())
              expect(object.toOneRelationship?.identifier) == 11
            }
            
            it("should remove old value") {
              expect(child.isInvalidated) == true

              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 10)).to(beNil())
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 1
            }
          }
          
          context("new value null") {
            beforeEach {
              let fixture = Fixture.build(usingFixture: "AssignmentPolicyToOneNull")!
              deserializer.fill(object, fromRepresentation: fixture, mapping: mapping)
            }
            
            it("should assign null") {
              expect(object.toOneRelationship).to(beNil())
            }
            
            it("should remove old value") {
              expect(child.isInvalidated) == true
              
              expect(realm.object(ofType: SwiftUniqueChildObject.self, forPrimaryKey: 10)).to(beNil())
              expect(realm.objects(SwiftUniqueChildObject.self).count) == 0
            }
          }
        }
      }
    }
  }
}
