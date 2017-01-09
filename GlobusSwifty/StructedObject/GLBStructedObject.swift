/*--------------------------------------------------*/

import Globus

/*--------------------------------------------------*/

extension GLBStructedObject {
    
    // MARK: Setters
    
    open func set(value: Bool?, forPath path: String) -> Bool {
        if let unwrapped = value {
            return self.set(value: unwrapped, forPath: path)
        }
        return self.set(object: nil, forPath: path)
    }
    
    open func set(value: Int?, forPath path: String) -> Bool {
        if let unwrapped = value {
            return self.set(value: unwrapped, forPath: path)
        }
        return self.set(object: nil, forPath: path)
    }
    
    open func set(value: UInt?, forPath path: String) -> Bool {
        if let unwrapped = value {
            return self.set(value: unwrapped, forPath: path)
        }
        return self.set(object: nil, forPath: path)
    }
    
    open func set(value: Float?, forPath path: String) -> Bool {
        if let unwrapped = value {
            return self.set(value: unwrapped, forPath: path)
        }
        return self.set(object: nil, forPath: path)
    }
    
    open func set(value: Double?, forPath path: String) -> Bool {
        if let unwrapped = value {
            return self.set(value: unwrapped, forPath: path)
        }
        return self.set(object: nil, forPath: path)
    }
    
    // MARK: Getters
    
    open func boolean(atPath path: String, or: Bool?) -> Bool? {
        if let number = self.number(atPath: path, or: nil) {
            return number.boolValue
        }
        return or
    }
    
    open func int(atPath path: String, or: Int?) -> Int? {
        if let number = self.number(atPath: path, or: nil) {
            return number.intValue
        }
        return or
    }
    
    open func uint(atPath path: String, or: UInt?) -> UInt? {
        if let number = self.number(atPath: path, or: nil) {
            return number.uintValue
        }
        return or
    }
    
    open func float(atPath path: String, or: Float?) -> Float? {
        if let number = self.number(atPath: path, or: nil) {
            return number.floatValue
        }
        return or
    }
    
    open func double(atPath path: String, or: Double?) -> Double? {
        if let number = self.number(atPath: path, or: nil) {
            return number.doubleValue
        }
        return or
    }
    
    // MARK: To object
    
    open func object(value: Bool?) -> Any? {
        if let safe = value {
            return self.object(value: safe)
        }
        return nil
    }
    
    open func object(value: Int?) -> Any? {
        if let safe = value {
            return self.object(value: safe)
        }
        return nil
    }
    
    open func object(value: UInt?) -> Any? {
        if let safe = value {
            return self.object(value: safe)
        }
        return nil
    }
    
    open func object(value: Float?) -> Any? {
        if let safe = value {
            return self.object(value: safe)
        }
        return nil
    }
    
    open func object(value: Double?) -> Any? {
        if let safe = value {
            return self.object(value: safe)
        }
        return nil
    }
    
    // MARK: From object
    
    open func boolean(from object: Any?, or: Bool?) -> Bool {
        if let safe = or {
            return self.boolean(from: object, or: safe)
        }
        return false
    }
    
    open func int(from object: Any?, or: Int?) -> Int {
        if let safe = or {
            return self.int(from: object, or: safe)
        }
        return 0
    }
    
    open func uint(from object: Any?, or: UInt?) -> UInt {
        if let safe = or {
            return self.uint(from: object, or: safe)
        }
        return 0
    }
    
    open func float(from object: Any?, or: Float?) -> Float {
        if let safe = or {
            return self.float(from: object, or: safe)
        }
        return 0
    }
    
    open func double(from object: Any?, or: Double?) -> Double {
        if let safe = or {
            return self.double(from: object, or: safe)
        }
        return 0
    }
    
}

/*--------------------------------------------------*/
