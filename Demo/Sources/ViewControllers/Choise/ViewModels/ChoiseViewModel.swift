//
//  Globus
//

import Globus

class ChoiseViewModel {
    
    var title: String = ""
    
    public init(title: String) {
        self.title = title
    }
    
    public func instantiateViewController() -> GLBViewController? {
        return nil
    }
    
}

class ChoiseControllerViewModel < ViewControllerClass : GLBViewController > : ChoiseViewModel {
    
    public override func instantiateViewController() -> GLBViewController? {
        return ViewControllerClass.instantiate()
    }
    
}
