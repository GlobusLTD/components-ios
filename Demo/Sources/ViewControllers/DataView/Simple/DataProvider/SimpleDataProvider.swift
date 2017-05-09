//
//  Globus
//

import Globus
import GlobusSwifty

class SimpleDataProvider: GLBLocalSimpleDataProvider {
    
    public override init() {
        super.init(baseFileName: "SimpleDataProvider")
        self.canReload = true
    }
    
    public override init(baseFileName: String) {
        super.init(baseFileName: baseFileName)
        self.canReload = true
    }
    
    public override func model(withJsonObject jsonObject: Any) -> Any? {
        return SimpleDataProviderModel.model(jsonObject: jsonObject)
    }
    
}

class SimpleDataProviderModel : GLBSwiftyModel {
    
    public var uid: String = ""
    public var url: URL?
    public var firstName: String = ""
    public var lastName: String = ""
    
    override func fromJson(json: GLBJson) {
        self.uid <<< (json, "id")
        self.url <<< (json, "avatar")
        self.firstName <<< (json, "first_name")
        self.lastName <<< (json, "last_name")
    }
    
}
