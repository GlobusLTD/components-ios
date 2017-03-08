//
//  Globus
//

import Globus
import GlobusSwifty

class ListDataProvider: GLBLocalListDataProvider {
    
    public override init() {
        super.init(baseFileName: "ListDataProvider")
        self.canReload = true
        self.canSearch = true
    }
    
    public override init(baseFileName: String) {
        super.init(baseFileName: baseFileName)
        self.canReload = true
        self.canSearch = true
    }
    
    public override func model(withJson json: Any) -> GLBListDataProviderModel? {
        return ListDataProviderGroupModel.model(jsonObject: json)
    }
    
}

class ListDataProviderGroupModel : GLBSwiftyModel {
    
    public var uid: String = ""
    public var items: [ ListDataProviderItemModel ] = []
    
    override func fromJson(json: GLBJson) {
        self.uid <<< (json, "id")
        self.items <<< (json, "childs")
    }
    
}

extension ListDataProviderGroupModel: GLBListDataProviderModel {
    
    public var header: Any? {
        get {
            return nil
        }
    }
    
    public var footer: Any? {
        get {
            return nil
        }
    }
    
    public var childs: [ Any ]? {
        get {
            return self.items as [ Any ]
        }
    }
    
}

class ListDataProviderItemModel : GLBSwiftyModel {
    
    public var uid: String = ""
    public var title: String = ""
    
    override func fromJson(json: GLBJson) {
        self.uid <<< (json, "id")
        self.title <<< (json, "title")
    }
    
}
