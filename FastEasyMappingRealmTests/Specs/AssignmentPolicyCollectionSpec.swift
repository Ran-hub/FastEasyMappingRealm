// For License please refer to LICENSE file in the root of FastEasyMapping project

import Quick
import Nimble
import FastEasyMappingRealm
import RealmSwift

class AssignmentPolicyCollectionSpec: QuickSpec {
  
  override func spec() {
    describe("mapping") {
      var object: SwiftObject!
      let mapping = SwiftObject.defaultMapping()
      
      var realm: Realm!
      var deserializer: FEMDeserializer!
      var store: FEMRealmStore!
      
      beforeEach {
        let configuration = Realm.Configuration(inMemoryIdentifier: "tests")
        realm = try! Realm(configuration: configuration)
        store = FEMRealmStore(realm: ObjectiveCSupport.convert(object: realm))
        deserializer = FEMDeserializer(store: store)
        
        let fixture = Fixture.build(usingFixture: "SupportedTypes") as! [AnyHashable: Any]
        object = deserializer.object(fromRepresentation: fixture, mapping: mapping) as! SwiftObject
      }
      
      afterEach {
        try! realm.write {
          realm.deleteAll()
        }
      }
      
      describe("non-null attributes") {
        it("should map bool value") {
          expect(object.boolValue) == true
        }
        
        it("should map bool object") {
            expect(object.boolObject.value) == true
        }
        
        it("should map malformed bool value") {
          expect(object.malformedBoolValue) == true
        }
        
        it("should map malformed bool object") {
            expect(object.malformedBoolObject.value) == true
        }
        
        it("should map char value") {
          expect(object.charValue) == Int8.max
        }
        
        it("should map char object") {
            expect(object.charObject.value) == Int8.max
        }
        
        it("should map short value") {
          expect(object.shortValue) == Int16.max
        }
        
        it("should map short object") {
            expect(object.shortObject.value) == Int16.max
        }
        
        it("should map int value") {
          expect(object.intValue) == Int32.max
        }
        
        it("should map int object") {
            expect(object.intValue) == Int32.max
        }

        it("should map longLong value") {
            expect(object.longLongValue) == Int64.max
        }

        it("should map longLong object") {
            expect(object.longLongObject.value) == Int64.max
        }
        
        it("should map floatValue") {
          expect(object.floatValue) == 11.1
        }
        
        it("should map doubleValue") {
          expect(object.doubleValue) == 12.2
        }

        it("should map string") {
          expect(object.string) == "string"
        }
        
        it("should map date") {
          let attribute = mapping.attribute(forProperty: "date")
          let expected = attribute?.mapValue("2017") as? Date
          expect(object.date) == expected
        }
        
        it("should map data") {
          let attribute = mapping.attribute(forProperty: "data")
          let expected = attribute?.mapValue("utf8") as? Data
          expect(object.data) == expected
        }
        
        it("should map to-one relationship") {
          expect(object.toOneRelationship).toNot(beNil())
          expect(object.toOneRelationship?.string) ==  "1"
        }
        
        it("should map to-many relationship") {
          expect(object.toManyRelationship.count) == 2
          expect(object.toManyRelationship[0].string) ==  "10"
          expect(object.toManyRelationship[1].string) ==  "11"
        }
      }
      
      describe("null attributes") {
        beforeEach {
          let fixture = Fixture.build(usingFixture: "SupportedTypesNull") as! [AnyHashable: Any]
          object = deserializer.fill(object, fromRepresentation: fixture, mapping: mapping) as! SwiftObject
        }
        
        it("should skip bool value") {
            expect(object.boolValue) == true
        }
        
        it("should nil bool object") {
            expect(object.boolObject.value).to(beNil())
        }
        
        it("should skip malformed bool value") {
            expect(object.malformedBoolValue) == true
        }
        
        it("should nil malformed bool object") {
            expect(object.malformedBoolObject.value).to(beNil())
        }
        
        it("should skip int8 (char) value") {
            expect(object.charValue) == Int8.max
        }
        
        it("should nil char object") {
            expect(object.charObject.value).to(beNil())
        }
        
        it("should skip short value") {
            expect(object.shortValue) == Int16.max
        }
        
        it("should nil short object") {
            expect(object.shortObject.value).to(beNil())
        }
        
        it("should skip int value") {
            expect(object.intValue) == Int32.max
        }
        
        it("should nil int object") {
            expect(object.intObject.value).to(beNil())
        }
        
        it("should skip longLong value") {
            expect(object.longLongValue) == Int64.max
        }
        
        it("should nil longLong object") {
            expect(object.longLongObject.value).to(beNil())
        }
        
        it("should skip floatValue") {
            expect(object.floatValue) == 11.1
        }
        
        it("should skip doubleValue") {
            expect(object.doubleValue) == 12.2
        }
        
        it("should nil string") {
            expect(object.string).to(beNil())
        }
        
        it("should nil date") {
            expect(object.date).to(beNil())
        }
        
        it("should nil data") {
            expect(object.data).to(beNil())
        }
        
        it("should nil to-one relationship") {
          expect(object.toOneRelationship).to(beNil())
        }
        
        it("should nil to-many relationship") {
          expect(object.toManyRelationship.count) == 0
        }
      }
    }
  }
}
