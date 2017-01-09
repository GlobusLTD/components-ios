/*--------------------------------------------------*/

import Globus

/*--------------------------------------------------*/

public protocol GLBJsonValueProrocol {
    
    static func from(json: GLBJson, value: Any?) -> Any?
    func to(json: GLBJson) -> Any?
    
}

/*--------------------------------------------------*/

extension Bool: GLBJsonValueProrocol {
    
    public static func from(json: GLBJson, value: Any?) -> Any? {
        return json.boolean(from: value, or: false)
    }
    
    public func to(json: GLBJson) -> Any? {
        return json.object(value: self)
    }
    
}

extension Int: GLBJsonValueProrocol {
    
    public static func from(json: GLBJson, value: Any?) -> Any? {
        return json.int(from: value, or: 0)
    }
    
    public func to(json: GLBJson) -> Any? {
        return json.object(value: self)
    }
    
}

extension UInt: GLBJsonValueProrocol {
    
    public static func from(json: GLBJson, value: Any?) -> Any? {
        return json.uint(from: value, or: 0)
    }
    
    public func to(json: GLBJson) -> Any? {
        return json.object(value: self)
    }
    
}

extension Float: GLBJsonValueProrocol {
    
    public static func from(json: GLBJson, value: Any?) -> Any? {
        return json.float(from: value, or: 0)
    }
    
    public func to(json: GLBJson) -> Any? {
        return json.object(value: self)
    }
    
}

extension Double: GLBJsonValueProrocol {
    
    public static func from(json: GLBJson, value: Any?) -> Any? {
        return json.double(from: value, or: 0)
    }
    
    public func to(json: GLBJson) -> Any? {
        return json.object(value: self)
    }
    
}

extension NSNumber: GLBJsonValueProrocol {
    
    public static func from(json: GLBJson, value: Any?) -> Any? {
        return json.number(from: value, or: nil)
    }
    
    public func to(json: GLBJson) -> Any? {
        return json.object(number: self)
    }
    
}

extension String: GLBJsonValueProrocol {
    
    public static func from(json: GLBJson, value: Any?) -> Any? {
        return json.string(from: value, or: nil)
    }
    
    public func to(json: GLBJson) -> Any? {
        return json.object(string: self)
    }
    
}

extension URL: GLBJsonValueProrocol {
    
    public static func from(json: GLBJson, value: Any?) -> Any? {
        return json.url(from: value, or: nil)
    }
    
    public func to(json: GLBJson) -> Any? {
        return json.object(url: self)
    }
    
}

extension Date: GLBJsonValueProrocol {
    
    public static func from(json: GLBJson, value: Any?) -> Any? {
        return json.date(from: value, or: nil)
    }
    
    public func to(json: GLBJson) -> Any? {
        return json.object(date: self)
    }
    
}

extension UIColor: GLBJsonValueProrocol {
    
    public static func from(json: GLBJson, value: Any?) -> Any? {
        return json.color(from: value, or: nil)
    }
    
    public func to(json: GLBJson) -> Any? {
        return json.object(color: self)
    }
    
}

/*--------------------------------------------------*/
// MARK: Operators
/*--------------------------------------------------*/

// Set
infix operator >>>

// Get
infix operator <<<

/*--------------------------------------------------*/
// MARK: Any
/*--------------------------------------------------*/

public func >>> < Type:GLBJsonValueProrocol >(left: Type, right: (GLBJson, String)) {
    if let object = left.to(json: right.0) {
        right.0.set(object: object, forPath: right.1)
    }
}

public func >>> < Type:GLBJsonValueProrocol >(left: Type?, right: (GLBJson, String)) {
    if let safe = left {
        safe >>> right
    } else {
        right.0.set(object: nil, forPath: right.1)
    }
}

public func <<< < Type:GLBJsonValueProrocol >(left: inout Type, right: (GLBJson, String)) {
    if let source = right.0.object(atPath: right.1) {
        if let object = Type.from(json: right.0, value: source) as? Type {
            left = object
        }
    }
}

public func <<< < Type:GLBJsonValueProrocol >(left: inout Type?, right: (GLBJson, String)) {
    if let source = right.0.object(atPath: right.1) {
        left = Type.from(json: right.0, value: source) as? Type
    }
}

public func <<< < Type:GLBJsonValueProrocol >(left: inout Type?, right: (GLBJson, String, Type?)) {
    if let source = right.0.object(atPath: right.1) {
        if let object = Type.from(json: right.0, value: source) as? Type {
            left = object
        } else {
            left = right.2
        }
    } else {
        left = right.2
    }
}

/*--------------------------------------------------*/
// MARK: Array
/*--------------------------------------------------*/

public func >>> < Type:GLBJsonValueProrocol >(left: [Type], right: (GLBJson, String)) {
    let array = left.map { (item: Type) -> Any? in
        return item.to(json: right.0)
    }
    right.0.set(array: array, forPath: right.1)
}

public func >>> < Type:GLBJsonValueProrocol >(left: [Type]?, right: (GLBJson, String)) {
    if let safe = left {
        safe >>> right
    } else {
        right.0.set(array: nil, forPath: right.1)
    }
}

public func >>> < Type:GLBJsonValueProrocol >(left: [Type], right: GLBJson) {
    let array = left.map { (item: Type) -> Any? in
        return item.to(json: right)
    }
    right.set(rootArray: array)
}

public func >>> < Type:GLBJsonValueProrocol >(left: [Type]?, right: GLBJson) {
    if let safe = left {
        safe >>> right
    } else {
        right.set(rootArray: nil)
    }
}

public func <<< < Type:GLBJsonValueProrocol >(left: inout [Type], right: (GLBJson, String)) {
    if let source = right.0.array(atPath: right.1) {
        left = source.flatMap({ (item: Any) -> Type? in
            return Type.from(json: right.0, value: item) as? Type
        })
    } else {
        left = []
    }
}

public func <<< < Type:GLBJsonValueProrocol >(left: inout [Type]?, right: (GLBJson, String)) {
    if let source = right.0.array(atPath: right.1) {
        left = source.flatMap({ (item: Any) -> Type? in
            return Type.from(json: right.0, value: item) as? Type
        })
    } else {
        left = nil
    }
}

public func <<< < Type:GLBJsonValueProrocol >(left: inout [Type], right: GLBJson) {
    if let source = right.rootArray() {
        left = source.flatMap({ (item: Any) -> Type? in
            return Type.from(json: right, value: item) as? Type
        })
    } else {
        left = []
    }
}

public func <<< < Type:GLBJsonValueProrocol >(left: inout [Type]?, right: GLBJson) {
    if let source = right.rootArray() {
        left = source.flatMap({ (item: Any) -> Type? in
            return Type.from(json: right, value: item) as? Type
        })
    } else {
        left = nil
    }
}

/*--------------------------------------------------*/
// MARK: Dictionary
/*--------------------------------------------------*/

public func >>> < Key: GLBJsonValueProrocol & Hashable, Value: GLBJsonValueProrocol >(left: [Key: Value], right: (GLBJson, String)) {
    var result: [AnyHashable: Any] = [:]
    left.forEach { (key: Key, value: Value) in
        if let safeKey = key.to(json: right.0) as? AnyHashable {
            if let safeValue = value.to(json: right.0) {
                result[safeKey] = safeValue
            }
        }
    }
    right.0.set(dictionary: result, forPath: right.1)
}

public func >>> < Key: GLBJsonValueProrocol & Hashable, Value: GLBJsonValueProrocol >(left: [Key: Value]?, right: (GLBJson, String)) {
    if let safe = left {
        safe >>> right
    } else {
        right.0.set(dictionary: nil, forPath: right.1)
    }
}

public func >>> < Key: GLBJsonValueProrocol & Hashable, Value: GLBJsonValueProrocol >(left: [Key: Value], right: GLBJson) {
    var result: [AnyHashable: Any] = [:]
    left.forEach { (key: Key, value: Value) in
        if let safeKey = key.to(json: right) as? AnyHashable {
            if let safeValue = value.to(json: right) {
                result[safeKey] = safeValue
            }
        }
    }
    right.set(rootDictionary: result)
}

public func >>> < Key: GLBJsonValueProrocol & Hashable, Value: GLBJsonValueProrocol >(left: [Key: Value]?, right: GLBJson) {
    if let safe = left {
        safe >>> right
    } else {
        right.set(rootDictionary: nil)
    }
}

public func <<< < Key: GLBJsonValueProrocol & Hashable, Value: GLBJsonValueProrocol >(left: inout [Key: Value], right: (GLBJson, String)) {
    if let source = right.0.dictionary(atPath: right.1) {
        var result: [Key: Value] = [:]
        source.forEach({ (key: AnyHashable, value: Any) in
            if let safeKey = Key.from(json: right.0, value: key) as? Key {
                if let safeValue = Value.from(json: right.0, value: value) as? Value {
                    result[safeKey] = safeValue
                }
            }
        })
        left = result
    } else {
        left = [:]
    }
}

public func <<< < Key: GLBJsonValueProrocol & Hashable, Value: GLBJsonValueProrocol >(left: inout [Key: Value]?, right: (GLBJson, String)) {
    if let source = right.0.dictionary(atPath: right.1) {
        var result: [Key: Value] = [:]
        source.forEach({ (key: AnyHashable, value: Any) in
            if let safeKey = Key.from(json: right.0, value: key) as? Key {
                if let safeValue = Value.from(json: right.0, value: value) as? Value {
                    result[safeKey] = safeValue
                }
            }
        })
        left = result
    } else {
        left = nil
    }
}

public func <<< < Key: GLBJsonValueProrocol & Hashable, Value: GLBJsonValueProrocol >(left: inout [Key: Value], right: GLBJson) {
    if let source = right.rootDictionary() {
        var result: [Key: Value] = [:]
        source.forEach({ (key: AnyHashable, value: Any) in
            if let safeKey = Key.from(json: right, value: key) as? Key {
                if let safeValue = Value.from(json: right, value: value) as? Value {
                    result[safeKey] = safeValue
                }
            }
        })
        left = result
    } else {
        left = [:]
    }
}

public func <<< < Key: GLBJsonValueProrocol & Hashable, Value: GLBJsonValueProrocol >(left: inout [Key: Value]?, right: GLBJson) {
    if let source = right.rootDictionary() {
        var result: [Key: Value] = [:]
        source.forEach({ (key: AnyHashable, value: Any) in
            if let safeKey = Key.from(json: right, value: key) as? Key {
                if let safeValue = Value.from(json: right, value: value) as? Value {
                    result[safeKey] = safeValue
                }
            }
        })
        left = result
    } else {
        left = nil
    }
}

/*--------------------------------------------------*/
// MARK: RawRepresentable
/*--------------------------------------------------*/

public func >>> < EnumType: RawRepresentable >(left: EnumType, right: (GLBJson, String)) where EnumType.RawValue: GLBJsonValueProrocol {
    left.rawValue >>> right
}

public func >>> < EnumType: RawRepresentable >(left: EnumType?, right: (GLBJson, String)) where EnumType.RawValue: GLBJsonValueProrocol {
    if let safeLeft = left {
        safeLeft >>> right
    } else {
        right.0.set(object: nil, forPath: right.1)
    }
}

public func <<< < EnumType: RawRepresentable >(left: inout EnumType, right: (GLBJson, String, EnumType)) where EnumType.RawValue: GLBJsonValueProrocol {
    var raw: EnumType.RawValue? = nil
    raw <<< (right.0, right.1, right.2.rawValue)
    if let safeRaw = raw {
        left = EnumType.init(rawValue: safeRaw)!
    } else {
        left = right.2
    }
}

public func <<< < EnumType: RawRepresentable >(left: inout EnumType?, right: (GLBJson, String, EnumType?)) where EnumType.RawValue: GLBJsonValueProrocol {
    var raw: EnumType.RawValue? = nil
    if let safeOr = right.2 {
        raw <<< (right.0, right.1, safeOr.rawValue)
    } else {
        raw <<< (right.0, right.1)
    }
    if let safeRaw = raw {
        left = EnumType.init(rawValue: safeRaw)!
    } else {
        left = right.2
    }
}

/*--------------------------------------------------*/
// MARK: Date
/*--------------------------------------------------*/

public func >>> (left: Date, right: (GLBJson, String)) {
    right.0.set(date: left, forPath: right.1)
}

public func >>> (left: Date?, right: (GLBJson, String)) {
    right.0.set(date: left, forPath: right.1)
}

public func >>> (left: Date, right: (GLBJson, String, String)) {
    right.0.set(date: left, format: right.2, forPath: right.1)
}

public func >>> (left: Date?, right: (GLBJson, String, String)) {
    right.0.set(date: left, format: right.2, forPath: right.1)
}

public func <<< (left: inout Date, right: (GLBJson, String, Date)) {
    if let safe = right.0.date(atPath: right.1, or: right.2) {
        left = safe
    } else {
        left = right.2
    }
}

public func <<< (left: inout Date?, right: (GLBJson, String, Date?)) {
    left = right.0.date(atPath: right.1, or: right.2)
}

public func <<< (left: inout Date, right: (GLBJson, String, String, Date)) {
    if let safe = right.0.date(atPath: right.1, formats: [ right.2 ], or: right.3) {
        left = safe
    } else {
        left = right.3
    }
}

public func <<< (left: inout Date?, right: (GLBJson, String, String, Date?)) {
    left = right.0.date(atPath: right.1, formats: [ right.2 ], or: right.3)
}

public func <<< (left: inout Date, right: (GLBJson, String, [String], Date)) {
    if let safe = right.0.date(atPath: right.1, formats: right.2, or: right.3) {
        left = safe
    } else {
        left = right.3
    }
}

public func <<< (left: inout Date?, right: (GLBJson, String, [String], Date?)) {
    left = right.0.date(atPath: right.1, formats: right.2, or: right.3)
}

/*--------------------------------------------------*/
// MARK: UIColor
/*--------------------------------------------------*/

public func >>> (left: UIColor, right: (GLBJson, String)) {
    right.0.set(color: left, forPath: right.1)
}

public func >>> (left: UIColor?, right: (GLBJson, String)) {
    right.0.set(color: left, forPath: right.1)
}

public func <<< (left: inout UIColor, right: (GLBJson, String, UIColor)) {
    if let safe = right.0.color(atPath: right.1, or: right.2) {
        left = safe
    } else {
        left = right.2
    }
}

public func <<< (left: inout UIColor?, right: (GLBJson, String, UIColor?)) {
    left = right.0.color(atPath: right.1, or: right.2)
}

/*--------------------------------------------------*/
