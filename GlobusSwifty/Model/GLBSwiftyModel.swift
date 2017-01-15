/*--------------------------------------------------*/

import Globus

/*--------------------------------------------------*/

public protocol GLBSwiftyModelProtocol {
    
    static func model(jsonObject: Any?) -> Self?
    static func model(jsonData: Data) -> Self?
    static func model(jsonString: String) -> Self?
    static func model(jsonString: String, encoding: UInt) -> Self?
    static func model(json: GLBJson) -> Self?
    
    static func model(packObject: Any?) -> Self?
    static func model(packData: Data) -> Self?
    static func model(pack: GLBPack) -> Self?
    
    init()
    
    func fromJson(object: Any?)
    func fromJson(data: Data)
    func fromJson(string: String)
    func fromJson(string: String, encoding: UInt)
    func fromJson(json: GLBJson)
    
    func unpack(object: Any?)
    func unpack(data: Data)
    func unpack(pack: GLBPack)
    
    func toJsonObject() -> Any?
    func toJsonData() -> Data?
    func toJsonString() -> String?
    func toJsonString(encoding: UInt) -> String?
    func toJson() -> GLBJson?
    func toJson(json: GLBJson)
    
    func packObject() -> Any?
    func packData() -> Data?
    func pack() -> GLBPack?
    func pack(pack: GLBPack)
    
}

/*--------------------------------------------------*/

open class GLBSwiftyModel: GLBSwiftyModelProtocol {
    
    // MARK: Public property
    
    open var storeName: String?
    open var storeDefaults: UserDefaults?
    open var storeFileUrl: URL?
    
    // MARK: Private const
    
    struct Const {
        static let Extension = "globus.swifty"
    }
    
    // MARK: Private static func
    
    private class func name(_ name: String) -> String {
        return name.appending(Const.Extension)
    }
    
    private class func fileUrl(fileName: String) -> URL? {
        var url = URL(fileURLWithPath: FileManager.glb_cachesDirectory())
        url.appendPathExtension(self.name(fileName))
        return url
    }
    
    private class func fileUrl(fileName: String, inAppGroup: String) -> URL? {
        if var url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: inAppGroup) {
            url.appendPathComponent(self.name(fileName))
            return url
        }
        return nil
    }
    
    // MARK: Public static func
    
    public final class func exist(name: String) -> Bool {
        return (UserDefaults.standard.data(forKey: self.name(name)) != nil)
    }
    
    public final class func exist(name: String, defaults: UserDefaults!) -> Bool {
        return (defaults.data(forKey: self.name(name)) != nil)
    }
    
    public final class func exist(fileName: String) -> Bool {
        if let fileUrl = self.fileUrl(fileName: fileName) {
            return FileManager.default.fileExists(atPath: fileUrl.path)
        }
        return false
    }
    
    public final class func exist(fileName: String, inAppGroup: String) -> Bool {
        if let fileUrl = self.fileUrl(fileName: fileName, inAppGroup: inAppGroup) {
            return FileManager.default.fileExists(atPath: fileUrl.path)
        }
        return false
    }
    
    public final class func model(name: String) -> Self? {
        return self.model(name: name, defaults: UserDefaults.standard)
    }
    
    public final class func model(name: String, defaults: UserDefaults) -> Self? {
        if let data = defaults.data(forKey: self.name(name)) {
            let model = self.init()
            model.storeName = name
            model.storeDefaults = defaults
            model.unpack(data: data)
            return model
        }
        return nil
    }
    
    public final class func model(fileName: String) -> Self? {
        if let fileUrl = self.fileUrl(fileName: fileName) {
            return self.model(fileName: fileName, fileUrl: fileUrl)
        }
        return nil
    }
    
    public final class func model(fileName: String, inAppGroup: String) -> Self? {
        if let fileUrl = self.fileUrl(fileName: fileName, inAppGroup: inAppGroup) {
            return self.model(fileName: fileName, fileUrl: fileUrl)
        }
        return nil
    }
    
    public final class func model(fileName: String, fileUrl: URL) -> Self? {
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            if let data = FileManager.default.contents(atPath: fileUrl.path) {
                let model = self.init()
                model.storeName = fileName
                model.storeFileUrl = fileUrl
                model.unpack(data: data)
                return model
            }
        }
        return nil
    }
    
    // MARK: Public init
    
    public required init() {
    }
    
    // MARK: Public func
    
    open func load() {
        if let safeStoreName = self.storeName {
            var data: Data? = nil
            if let safeStoreDefaults = self.storeDefaults {
                data = safeStoreDefaults.data(forKey: GLBSwiftyModel.name(safeStoreName))
            } else if let safeStoreFileUrl = self.storeFileUrl {
                data = try? Data.init(contentsOf: safeStoreFileUrl)
            }
            if data != nil {
                self.unpack(data: data!)
            }
        }
    }
    
    @discardableResult
    open func save() -> Bool {
        var result = false
        if let safeStoreName = self.storeName {
            if let safePack = self.packData() {
                if let safeStoreDefaults = self.storeDefaults {
                    safeStoreDefaults.set(safePack, forKey: GLBSwiftyModel.name(safeStoreName))
                    result = true
                } else if let safeStoreFileUrl = self.storeFileUrl {
                    try? safePack.write(to: safeStoreFileUrl)
                    result = true
                }
            }
        }
        return result
    }
    
    open func erase() {
        if let safeStoreName = self.storeName {
            if let safeStoreDefaults = self.storeDefaults {
                safeStoreDefaults.set(nil, forKey: GLBSwiftyModel.name(safeStoreName))
            } else if let safeStoreFileUrl = self.storeFileUrl {
                try? FileManager.default.removeItem(at: safeStoreFileUrl)
            }
        }
    }
    
    // MARK: GLBSwiftyModelProtocol
    
    public final class func model(jsonObject: Any?) -> Self? {
        return self.model(json: GLBJson.init(rootObject: jsonObject))
    }
    
    public final class func model(jsonData: Data) -> Self? {
        return self.model(json: GLBJson.init(data: jsonData))
    }
    
    public final class func model(jsonString: String) -> Self? {
        return self.model(json: GLBJson.init(string: jsonString))
    }
    
    public final class func model(jsonString: String, encoding: UInt) -> Self? {
        return self.model(json: GLBJson.init(string: jsonString, encoding: encoding))
    }
    
    public final class func model(json: GLBJson) -> Self? {
        let model = self.init()
        model.fromJson(json: json)
        return model
    }
    
    public final class func model(packObject: Any?) -> Self? {
        return self.model(pack: GLBPack.init(rootObject: packObject))
    }
    
    public final class func model(packData: Data) -> Self? {
        return self.model(pack: GLBPack.init(data: packData))
    }
    
    public final class func model(pack: GLBPack) -> Self? {
        let model = self.init()
        model.unpack(pack: pack)
        return model
    }
    
    public final func fromJson(object: Any?) {
        self.fromJson(json: GLBJson.init(rootObject: object))
    }
    
    public final func fromJson(data: Data) {
        self.fromJson(json: GLBJson.init(data: data))
    }
    
    public final func fromJson(string: String) {
        self.fromJson(json: GLBJson.init(string: string))
    }
    
    public final func fromJson(string: String, encoding: UInt) {
        self.fromJson(json: GLBJson.init(string: string, encoding: encoding))
    }
    
    open func fromJson(json: GLBJson) {
    }
    
    public final func unpack(object: Any?) {
        self.unpack(pack: GLBPack.init(rootObject: object))
    }
    
    public final func unpack(data: Data) {
        self.unpack(pack: GLBPack.init(data: data))
    }
    
    open func unpack(pack: GLBPack) {
    }
    
    public final func toJsonObject() -> Any? {
        if let json = self.toJson() {
            return json.rootObject
        }
        return nil
    }
    
    public final func toJsonData() -> Data? {
        if let json = self.toJson() {
            return json.toData()
        }
        return nil
    }
    
    public final func toJsonString() -> String? {
        if let json = self.toJson() {
            return json.toString()
        }
        return nil
    }
    
    public final func toJsonString(encoding: UInt) -> String? {
        if let json = self.toJson() {
            return json.toString(encoding: encoding)
        }
        return nil
    }
    
    public final func toJson() -> GLBJson? {
        let json = GLBJson.init()
        self.toJson(json: json)
        return json
    }
    
    open func toJson(json: GLBJson) {
    }
    
    public final func packObject() -> Any? {
        if let pack = self.pack() {
            return pack.rootObject
        }
        return nil
    }
    
    public final func packData() -> Data? {
        if let pack = self.pack() {
            return pack.toData()
        }
        return nil
    }
    
    public final func pack() -> GLBPack? {
        let pack = GLBPack.init()
        self.pack(pack: pack)
        return pack
    }
    
    open func pack(pack: GLBPack) {
    }
    
}

/*--------------------------------------------------*/

extension GLBSwiftyModel: GLBJsonValueProrocol {
    
    public static func from(json: GLBJson, value: Any?) -> Any? {
        return self.model(jsonObject: value)
    }
    
    public func to(json: GLBJson) -> Any? {
        return self.toJsonObject()
    }
    
}

/*--------------------------------------------------*/

extension GLBSwiftyModel: GLBPackValueProrocol {
    
    public static func from(pack: GLBPack, value: Any?) -> Any? {
        return self.model(packObject: value)
    }
    
    public func to(pack: GLBPack) -> Any? {
        return self.packObject()
    }
    
}

/*--------------------------------------------------*/
