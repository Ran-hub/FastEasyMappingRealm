// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

import Foundation
import RealmSwift
import FastEasyMapping

class SwiftChildObject: Object {

  dynamic var string: String = ""
}

extension SwiftChildObject {
  
  class func defaultMapping() -> FEMMapping {
    let mapping = FEMMapping(objectClass: self)
    mapping.addAttributes(from: ["string"])
    return mapping
  }
}
