/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@class GLBInputForm;

/*--------------------------------------------------*/

@protocol GLBInputValidator;

/*--------------------------------------------------*/

@protocol GLBInputField <NSObject>

@property(nonatomic, weak) GLBInputForm* form;
@property(nonatomic, strong) id< GLBInputValidator > validator;

@required
- (void)validate;
- (NSArray*)messages;

@end

/*--------------------------------------------------*/
