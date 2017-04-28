// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

import Foundation
import FastEasyMapping
import RealmSwift

class SwiftUniqueObject: Object {

  dynamic var identifier: Int32 = 0
  
  override class func primaryKey() -> String? {
    return "identifier"
  }
  
  dynamic var toOneRelationship: SwiftUniqueObjectChild?
  let toManyRelationship = List<SwiftUniqueObjectChild>()
}

extension SwiftUniqueObject {
  
  class func defaultMapping() -> FEMMapping {
    let mapping = FEMMapping(objectClass: self)
    mapping.primaryKey = "identifier"
    mapping.addAttributes(from: ["identifier"])
    return mapping
  }
  
  class func toOneRelationshipMapping(with policy: @escaping FEMAssignmentPolicy) -> FEMMapping {
    let mapping = self.defaultMapping()
    
    let child = FEMRelationship(property: "toOneRelationship", keyPath: "toOne", mapping: SwiftUniqueObjectChild.defaultMapping())
    child.assignmentPolicy = policy
    mapping.addRelationship(child)
    
    return mapping
  }
  
  class func toManyRelationshipMapping(with policy: @escaping FEMAssignmentPolicy) -> FEMMapping {
    let mapping = self.defaultMapping()
    
    let child = FEMRelationship(property: "toManyRelationship", keyPath: "toMany", mapping: SwiftUniqueObjectChild.defaultMapping())
    child.assignmentPolicy = policy
    child.isToMany = true
    mapping.addRelationship(child)
    
    return mapping
  }
}
