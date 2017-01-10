/*--------------------------------------------------*/

import Globus

/*--------------------------------------------------*/

public protocol GLBPackValueProrocol {
    
    static func from(pack: GLBPack, value: Any?) -> Any?
    func to(pack: GLBPack) -> Any?
    
}

/*--------------------------------------------------*/

extension Bool: GLBPackValueProrocol {
    
    public static func from(pack: GLBPack, value: Any?) -> Any? {
        return pack.boolean(from: value, or: false)
    }
    
    public func to(pack: GLBPack) -> Any? {
        return pack.object(value: self)
    }
    
}

extension Int: GLBPackValueProrocol {
    
    public static func from(pack: GLBPack, value: Any?) -> Any? {
        return pack.int(from: value, or: 0)
    }
    
    public func to(pack: GLBPack) -> Any? {
        return pack.object(value: self)
    }
    
}

extension UInt: GLBPackValueProrocol {
    
    public static func from(pack: GLBPack, value: Any?) -> Any? {
        return pack.uint(from: value, or: 0)
    }
    
    public func to(pack: GLBPack) -> Any? {
        return pack.object(value: self)
    }
    
}

extension Float: GLBPackValueProrocol {
    
    public static func from(pack: GLBPack, value: Any?) -> Any? {
        return pack.float(from: value, or: 0)
    }
    
    public func to(pack: GLBPack) -> Any? {
        return pack.object(value: self)
    }
    
}

extension Double: GLBPackValueProrocol {
    
    public static func from(pack: GLBPack, value: Any?) -> Any? {
        return pack.double(from: value, or: 0)
    }
    
    public func to(pack: GLBPack) -> Any? {
        return pack.object(value: self)
    }
    
}

extension NSNumber: GLBPackValueProrocol {
    
    public static func from(pack: GLBPack, value: Any?) -> Any? {
        return pack.number(from: value, or: nil)
    }
    
    public func to(pack: GLBPack) -> Any? {
        return pack.object(number: self)
    }
    
}

extension String: GLBPackValueProrocol {
    
    public static func from(pack: GLBPack, value: Any?) -> Any? {
        return pack.string(from: value, or: nil)
    }
    
    public func to(pack: GLBPack) -> Any? {
        return pack.object(string: self)
    }
    
}

extension URL: GLBPackValueProrocol {
    
    public static func from(pack: GLBPack, value: Any?) -> Any? {
        return pack.url(from: value, or: nil)
    }
    
    public func to(pack: GLBPack) -> Any? {
        return pack.object(url: self)
    }
    
}

extension Date: GLBPackValueProrocol {
    
    public static func from(pack: GLBPack, value: Any?) -> Any? {
        return pack.date(from: value, or: nil)
    }
    
    public func to(pack: GLBPack) -> Any? {
        return pack.object(date: self)
    }
    
}

extension UIColor: GLBPackValueProrocol {
    
    public static func from(pack: GLBPack, value: Any?) -> Any? {
        return pack.color(from: value, or: nil)
    }
    
    public func to(pack: GLBPack) -> Any? {
        return pack.object(color: self)
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

public func >>> < Type:GLBPackValueProrocol >(left: Type, right: (GLBPack, String)) {
    if let object = left.to(pack: right.0) {
        right.0.set(object: object, forPath: right.1)
    }
}

public func >>> < Type:GLBPackValueProrocol >(left: Type?, right: (GLBPack, String)) {
    if let safe = left {
        safe >>> right
    } else {
        right.0.set(object: nil, forPath: right.1)
    }
}

public func <<< < Type:GLBPackValueProrocol >(left: inout Type, right: (GLBPack, String)) {
    if let source = right.0.object(atPath: right.1) {
        if let object = Type.from(pack: right.0, value: source) as? Type {
            left = object
        }
    }
}

public func <<< < Type:GLBPackValueProrocol >(left: inout Type?, right: (GLBPack, String)) {
    if let source = right.0.object(atPath: right.1) {
        left = Type.from(pack: right.0, value: source) as? Type
    }
}

public func <<< < Type:GLBPackValueProrocol >(left: inout Type?, right: (GLBPack, String, Type?)) {
    if let source = right.0.object(atPath: right.1) {
        if let object = Type.from(pack: right.0, value: source) as? Type {
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

public func >>> < Type:GLBPackValueProrocol >(left: [Type], right: (GLBPack, String)) {
    var array: [Any] = []
    left.forEach { (item: Type) in
        if let object = item.to(pack: right.0) {
            array.append(object)
        }
    }
    right.0.set(array: array, forPath: right.1)
}

public func >>> < Type:GLBPackValueProrocol >(left: [Type]?, right: (GLBPack, String)) {
    if let safe = left {
        safe >>> right
    } else {
        right.0.set(array: nil, forPath: right.1)
    }
}

public func >>> < Type:GLBPackValueProrocol >(left: [Type], right: GLBPack) {
    var array: [Any] = []
    left.forEach { (item: Type) in
        if let object = item.to(pack: right) {
            array.append(object)
        }
    }
    right.set(rootArray: array)
}

public func >>> < Type:GLBPackValueProrocol >(left: [Type]?, right: GLBPack) {
    if let safe = left {
        safe >>> right
    } else {
        right.set(rootArray: nil)
    }
}

public func <<< < Type:GLBPackValueProrocol >(left: inout [Type], right: (GLBPack, String)) {
    if let source = right.0.array(atPath: right.1) {
        left = source.flatMap({ (item: Any) -> Type? in
            return Type.from(pack: right.0, value: item) as? Type
        })
    } else {
        left = []
    }
}

public func <<< < Type:GLBPackValueProrocol >(left: inout [Type]?, right: (GLBPack, String)) {
    if let source = right.0.array(atPath: right.1) {
        left = source.flatMap({ (item: Any) -> Type? in
            return Type.from(pack: right.0, value: item) as? Type
        })
    } else {
        left = nil
    }
}

public func <<< < Type:GLBPackValueProrocol >(left: inout [Type], right: GLBPack) {
    if let source = right.rootArray() {
        left = source.flatMap({ (item: Any) -> Type? in
            return Type.from(pack: right, value: item) as? Type
        })
    } else {
        left = []
    }
}

public func <<< < Type:GLBPackValueProrocol >(left: inout [Type]?, right: GLBPack) {
    if let source = right.rootArray() {
        left = source.flatMap({ (item: Any) -> Type? in
            return Type.from(pack: right, value: item) as? Type
        })
    } else {
        left = nil
    }
}

/*--------------------------------------------------*/
// MARK: Dictionary
/*--------------------------------------------------*/

public func >>> < Key: GLBPackValueProrocol & Hashable, Value: GLBPackValueProrocol >(left: [Key: Value], right: (GLBPack, String)) {
    var result: [AnyHashable: Any] = [:]
    left.forEach { (key: Key, value: Value) in
        if let safeKey = key.to(pack: right.0) as? AnyHashable {
            if let safeValue = value.to(pack: right.0) {
                result[safeKey] = safeValue
            }
        }
    }
    right.0.set(dictionary: result, forPath: right.1)
}

public func >>> < Key: GLBPackValueProrocol & Hashable, Value: GLBPackValueProrocol >(left: [Key: Value]?, right: (GLBPack, String)) {
    if let safe = left {
        safe >>> right
    } else {
        right.0.set(dictionary: nil, forPath: right.1)
    }
}

public func >>> < Key: GLBPackValueProrocol & Hashable, Value: GLBPackValueProrocol >(left: [Key: Value], right: GLBPack) {
    var result: [AnyHashable: Any] = [:]
    left.forEach { (key: Key, value: Value) in
        if let safeKey = key.to(pack: right) as? AnyHashable {
            if let safeValue = value.to(pack: right) {
                result[safeKey] = safeValue
            }
        }
    }
    right.set(rootDictionary: result)
}

public func >>> < Key: GLBPackValueProrocol & Hashable, Value: GLBPackValueProrocol >(left: [Key: Value]?, right: GLBPack) {
    if let safe = left {
        safe >>> right
    } else {
        right.set(rootDictionary: nil)
    }
}

public func <<< < Key: GLBPackValueProrocol & Hashable, Value: GLBPackValueProrocol >(left: inout [Key: Value], right: (GLBPack, String)) {
    if let source = right.0.dictionary(atPath: right.1) {
        var result: [Key: Value] = [:]
        source.forEach({ (key: AnyHashable, value: Any) in
            if let safeKey = Key.from(pack: right.0, value: key) as? Key {
                if let safeValue = Value.from(pack: right.0, value: value) as? Value {
                    result[safeKey] = safeValue
                }
            }
        })
        left = result
    } else {
        left = [:]
    }
}

public func <<< < Key: GLBPackValueProrocol & Hashable, Value: GLBPackValueProrocol >(left: inout [Key: Value]?, right: (GLBPack, String)) {
    if let source = right.0.dictionary(atPath: right.1) {
        var result: [Key: Value] = [:]
        source.forEach({ (key: AnyHashable, value: Any) in
            if let safeKey = Key.from(pack: right.0, value: key) as? Key {
                if let safeValue = Value.from(pack: right.0, value: value) as? Value {
                    result[safeKey] = safeValue
                }
            }
        })
        left = result
    } else {
        left = nil
    }
}

public func <<< < Key: GLBPackValueProrocol & Hashable, Value: GLBPackValueProrocol >(left: inout [Key: Value], right: GLBPack) {
    if let source = right.rootDictionary() {
        var result: [Key: Value] = [:]
        source.forEach({ (key: AnyHashable, value: Any) in
            if let safeKey = Key.from(pack: right, value: key) as? Key {
                if let safeValue = Value.from(pack: right, value: value) as? Value {
                    result[safeKey] = safeValue
                }
            }
        })
        left = result
    } else {
        left = [:]
    }
}

public func <<< < Key: GLBPackValueProrocol & Hashable, Value: GLBPackValueProrocol >(left: inout [Key: Value]?, right: GLBPack) {
    if let source = right.rootDictionary() {
        var result: [Key: Value] = [:]
        source.forEach({ (key: AnyHashable, value: Any) in
            if let safeKey = Key.from(pack: right, value: key) as? Key {
                if let safeValue = Value.from(pack: right, value: value) as? Value {
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

public func >>> < EnumType: RawRepresentable >(left: EnumType, right: (GLBPack, String)) where EnumType.RawValue: GLBPackValueProrocol {
    left.rawValue >>> right
}

public func >>> < EnumType: RawRepresentable >(left: EnumType?, right: (GLBPack, String)) where EnumType.RawValue: GLBPackValueProrocol {
    if let safeLeft = left {
        safeLeft >>> right
    } else {
        right.0.set(object: nil, forPath: right.1)
    }
}

public func <<< < EnumType: RawRepresentable >(left: inout EnumType, right: (GLBPack, String, EnumType)) where EnumType.RawValue: GLBPackValueProrocol {
    var raw: EnumType.RawValue? = nil
    raw <<< (right.0, right.1, right.2.rawValue)
    if let safeRaw = raw {
        left = EnumType.init(rawValue: safeRaw)!
    } else {
        left = right.2
    }
}

public func <<< < EnumType: RawRepresentable >(left: inout EnumType?, right: (GLBPack, String, EnumType?)) where EnumType.RawValue: GLBPackValueProrocol {
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

public func >>> (left: Date, right: (GLBPack, String)) {
    right.0.set(date: left, forPath: right.1)
}

public func >>> (left: Date?, right: (GLBPack, String)) {
    right.0.set(date: left, forPath: right.1)
}

public func <<< (left: inout Date, right: (GLBPack, String, Date)) {
    if let safe = right.0.date(atPath: right.1, or: right.2) {
        left = safe
    } else {
        left = right.2
    }
}

public func <<< (left: inout Date?, right: (GLBPack, String, Date?)) {
    left = right.0.date(atPath: right.1, or: right.2)
}

/*--------------------------------------------------*/
// MARK: UIColor
/*--------------------------------------------------*/

public func >>> (left: UIColor, right: (GLBPack, String)) {
    right.0.set(color: left, forPath: right.1)
}

public func >>> (left: UIColor?, right: (GLBPack, String)) {
    right.0.set(color: left, forPath: right.1)
}

public func <<< (left: inout UIColor, right: (GLBPack, String, UIColor)) {
    if let safe = right.0.color(atPath: right.1, or: right.2) {
        left = safe
    } else {
        left = right.2
    }
}

public func <<< (left: inout UIColor?, right: (GLBPack, String, UIColor?)) {
    left = right.0.color(atPath: right.1, or: right.2)
}

/*--------------------------------------------------*/
