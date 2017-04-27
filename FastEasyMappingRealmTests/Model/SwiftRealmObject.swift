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
class RealmObject: Object {
  // Scalar types
  
  dynamic var boolValue: Bool = false
  let boolObject = RealmOptional<Bool>()
  
  dynamic var malformedBoolValue: Bool = false // when JSON contains 1/0 instead of true/false
  let malformedBoolObject = RealmOptional<Bool>()
  
  dynamic var int8Value: Int8 = 0
  let int8Object = RealmOptional<Int8>()
  
  dynamic var int16Value: Int16 = 0
  let int16Object = RealmOptional<Int16>()
  
  dynamic var int32Value: Int32 = 0
  let int32Object = RealmOptional<Int32>()

  dynamic var int64Value: Int64 = 0
  let int64Object = RealmOptional<Int64>()

  dynamic var floatValue: Float = 0
  let floatObject = RealmOptional<Float>()

  dynamic var doubleValue: Double = 0
  let doubleObject = RealmOptional<Double>()

  dynamic var string: String?
  dynamic var date: Date?
  dynamic var data: Data?
  
  dynamic var toOneRelationship: RealmObjectChild?
  let toManyRelationship = List<RealmObjectChild>()
}

extension RealmObject {
  
  class func defaultMapping() -> FEMMapping {
    let mapping = FEMMapping(objectClass: self)
    
    let schema = RLMObjectSchema(forObjectClass: self)
    mapping.addAttributes(from: schema.properties.map { $0.name })
//    
//    
//    for property in  {
//      
//    }
//    
//    mapping.addAttributes(from: [
//      "boolValue",
//      #keyPath(malformedBoolValue),
//      
//      #keyPath(charValue),
//      #keyPath(ucharValue),
//      
//      #keyPath(shortValue),
//      #keyPath(ushortValue),
//      
//      #keyPath(intValue),
//      #keyPath(uintValue),
//      
//      #keyPath(longValue),
//      #keyPath(ulongValue),
//      
//      #keyPath(longLongValue),
//      #keyPath(ulongLongValue),
//      
//      #keyPath(floatValue),
//      #keyPath(doubleValue),
//      
//      // Common bridgeable types
//      
//      #keyPath(nsnumberBool),
//      
//      #keyPath(string),
//      
//      #keyPath(arrayOfStrings),
//      #keyPath(setOfStrings)
//      ])
//    
//    mapping.addAttribute(FEMAttribute.mapping(ofURLProperty: #keyPath(url), toKeyPath: "url"))
//    mapping.addAttribute(FEMAttribute.mapping(ofProperty: #keyPath(date), toKeyPath: "date", dateFormat: "YYYY"))
//    mapping.addAttribute(FEMAttribute.stringToDataMapping(of: #keyPath(data), keyPath: "data"))
    
//    let child = FEMMapping(objectClass: ObjectChild.self)
//    child.addAttributes(from: [#keyPath(string)])
//    mapping.add(toManyRelationshipMapping: child, forProperty: #keyPath(children), keyPath: "children")
    
    return mapping
  }
}
