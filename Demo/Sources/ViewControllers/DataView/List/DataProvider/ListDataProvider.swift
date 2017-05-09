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
    
    public override func model(withJsonObject jsonObject: Any) -> Any? {
        return ListDataProviderModel.model(jsonObject: jsonObject)
    }
    
}

class ListDataProviderModel : GLBSwiftyModel {
    
    public var uid: String = ""
    public var title: String = ""
    
    override func fromJson(json: GLBJson) {
        self.uid <<< (json, "id")
        self.title <<< (json, "title")
    }
    
}
