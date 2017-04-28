// For License please refer to LICENSE file in the root of FastEasyMappingRealm project

import Foundation
import FastEasyMappingRealm
import Realm
import RealmSwift

/**
 * Realm 2.6.2
 * Supported types
 * Bool, Int, Int8, Int16, Int32, Int64, Double, Float, String, NSDate, and NSData.
 *
 * Types cheatsheet (https://realm.io/docs/swift/2.6.2/#cheatsheet)
 *
 Type         Non-optional                    Optional
 Bool         dynamic var value = false       let value = RealmOptional<Bool>()
 Int          dynamic var value = 0           let value = RealmOptional<Int>()
 Float        dynamic var value: Float = 0.0	let value = RealmOptional<Float>()
 Double       dynamic var value: Double = 0.0	let value = RealmOptional<Double>()
 String       dynamic var value = ""          dynamic var value: String? = nil
 Data         dynamic var value = NSData()    dynamic var value: NSData? = nil
 Date         dynamic var value = NSDate()    dynamic var value: NSDate? = nil
 Object       n/a: must be optional           dynamic var value: Class?
 List         let value = List<Class>()       n/a: must be non-optional
 */
class SwiftObject: Object {
  // Scalar types
  
  dynamic var boolValue: Bool = false
  let boolObject = RealmOptional<Bool>()
  
  dynamic var malformedBoolValue: Bool = false // when JSON contains 1/0 instead of true/false
  let malformedBoolObject = RealmOptional<Bool>()
  
  dynamic var charValue: Int8 = 0
  let charObject = RealmOptional<Int8>()
  
  dynamic var shortValue: Int16 = 0
  let shortObject = RealmOptional<Int16>()
  
  dynamic var intValue: Int32 = 0
  let intObject = RealmOptional<Int32>()

  dynamic var longLongValue: Int64 = 0
  let longLongObject = RealmOptional<Int64>()

  dynamic var floatValue: Float = 0
  let floatObject = RealmOptional<Float>()

  dynamic var doubleValue: Double = 0
  let doubleObject = RealmOptional<Double>()

  dynamic var string: String?
  dynamic var date: Date?
  dynamic var data: Data?
  
  dynamic var toOneRelationship: SwiftObjectChild?
  let toManyRelationship = List<SwiftObjectChild>()
}

extension SwiftObject {
  
  class func defaultMapping() -> FEMMapping {
    let mapping = FEMMapping(objectClass: self)
    mapping.addAttributes(from: [
      "boolValue",
      "boolObject",
      "malformedBoolValue",
      "malformedBoolObject",
      "charValue",
      "charObject",
      "shortValue",
      "shortObject",
      "intValue",
      "intObject",
      "longLongValue",
      "longLongObject",
      "floatValue",
      "floatObject",
      "doubleValue",
      "doubleObject",
      "string"
    ])
    
    mapping.addAttribute(FEMAttribute.mapping(ofProperty: "date", toKeyPath: "date", dateFormat: "YYYY"))
    mapping.addAttribute(FEMAttribute.stringToDataMapping(of: "data", keyPath: "data"))

    let child = SwiftObjectChild.defaultMapping()
    mapping.addRelationshipMapping(child, forProperty: "toOneRelationship", keyPath: "toOneRelationship")
    mapping.add(toManyRelationshipMapping: child, forProperty: "toManyRelationship", keyPath: "toManyRelationship")
    
    return mapping
  }
}
