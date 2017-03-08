/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

#import "GLBAction.h"

/*--------------------------------------------------*/

@protocol GLBInputField;
@protocol GLBInputValidator;

/*--------------------------------------------------*/

@interface GLBInputForm : NSObject

@property(nonatomic, strong) IBOutletCollection(NSObject) NSArray< id< GLBInputField > >* fields;
@property(nonatomic, strong) GLBAction* actionChangeState;
@property(nonatomic, readonly, getter=isValid) BOOL valid;

- (void)addField:(id< GLBInputField >)field;
- (void)removeField:(id< GLBInputField >)field;
- (void)removeAllFields;

- (NSArray*)invalidFields;
- (NSString*)output;

- (void)performValidator:(id< GLBInputValidator >)validator value:(id)value;

@end

/*--------------------------------------------------*/
