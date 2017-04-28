// For License please refer to LICENSE file in the root of FastEasyMapping project

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
      var child: SwiftUniqueObjectChild!
      
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
    }
  }
}
