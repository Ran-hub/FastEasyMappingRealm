// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

import Foundation
import RealmSwift
import FastEasyMapping

class SwiftUniqueChildObject: Object {

  dynamic var identifier: Int32 = 0
  
  override class func primaryKey() -> String? {
    return "identifier"
  }
}

extension SwiftUniqueChildObject {
  
  class func defaultMapping() -> FEMMapping {
    let mapping = FEMMapping(objectClass: self)
    mapping.primaryKey = "identifier"
    mapping.addAttributes(from: ["identifier"])
    return mapping
  }
}
