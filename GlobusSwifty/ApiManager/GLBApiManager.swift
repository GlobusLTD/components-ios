/*--------------------------------------------------*/

import Globus

/*--------------------------------------------------*/

public typealias GLBSwiftyApiProviderCompleteBlock< RequestType: GLBApiRequest, ResponseType: GLBApiResponse > = (RequestType, ResponseType) -> Swift.Void

/*--------------------------------------------------*/

extension GLBApiProvider {
    
    open func send< RequestType: GLBApiRequest, ResponseType: GLBApiResponse >(
        _ request: RequestType,
        byTarget target: Any,
        complete completeBlock: GLBSwiftyApiProviderCompleteBlock< RequestType, ResponseType >? = nil) {
        return self.send(request, byTarget: target, complete: { (completeRequest: Any, completeResponse: Any) -> Void in
            if (completeBlock != nil) && (completeRequest is RequestType) && (completeResponse is ResponseType) {
                completeBlock!(completeRequest as! RequestType, completeResponse as! ResponseType)
            }
        })
    }
    
    open func send< RequestType: GLBApiRequest, ResponseType: GLBApiResponse >(
        _ request: GLBApiRequest,
        byTarget target: Any,
        downloadBlock: Globus.GLBApiProviderProgressBlock?,
        complete completeBlock: GLBSwiftyApiProviderCompleteBlock< RequestType, ResponseType >? = nil) {
        return self.send(request, byTarget: target, downloadBlock: downloadBlock, complete: { (completeRequest: Any, completeResponse: Any) -> Void in
            if (completeBlock != nil) && (completeRequest is RequestType) && (completeResponse is ResponseType) {
                completeBlock!(completeRequest as! RequestType, completeResponse as! ResponseType)
            }
        })
    }
    
    open func send< RequestType: GLBApiRequest, ResponseType: GLBApiResponse >(
        _ request: GLBApiRequest,
        byTarget target: Any,
        uploadBlock: Globus.GLBApiProviderProgressBlock?,
        complete completeBlock: GLBSwiftyApiProviderCompleteBlock< RequestType, ResponseType >? = nil) {
        return self.send(request, byTarget: target, uploadBlock: uploadBlock, complete: { (completeRequest: Any, completeResponse: Any) -> Void in
            if (completeBlock != nil) && (completeRequest is RequestType) && (completeResponse is ResponseType) {
                completeBlock!(completeRequest as! RequestType, completeResponse as! ResponseType)
            }
        })
    }
    
}

/*--------------------------------------------------*/
