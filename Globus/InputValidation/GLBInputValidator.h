/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@protocol GLBInputField;

/*--------------------------------------------------*/

@protocol GLBInputValidator < NSObject >

@property(nonatomic, weak) id< GLBInputField > field;

@required
- (BOOL)validate:(id)value;
- (NSArray*)messages:(id)value;

@end

/*--------------------------------------------------*/

@interface GLBInputEmptyValidator : NSObject < GLBInputValidator >

@property(nonatomic, strong) IBInspectable NSString* message;
@property(nonatomic, readonly, assign, getter=isRequired) IBInspectable BOOL required;

- (instancetype)initWithMessage:(NSString*)message;

@end

/*--------------------------------------------------*/

@interface GLBInputEmailValidator : NSObject < GLBInputValidator >

@property(nonatomic, strong) IBInspectable NSString* message;
@property(nonatomic, readonly, assign, getter=isRequired) IBInspectable BOOL required;

- (instancetype)initWithMessage:(NSString*)message;

@end

/*--------------------------------------------------*/

@interface GLBInputRegExpValidator : NSObject < GLBInputValidator >

@property(nonatomic, strong) IBInspectable NSString* message;
@property(nonatomic, strong) IBInspectable NSString* regExp;
@property(nonatomic, readonly, assign, getter=isRequired) IBInspectable BOOL required;

- (instancetype)initWithRegExp:(NSString*)regExp andMessage:(NSString*)message;

@end

/*--------------------------------------------------*/

@interface GLBInputMinLengthValidator : NSObject < GLBInputValidator >

@property(nonatomic, strong) IBInspectable NSString* message;
@property(nonatomic) IBInspectable NSInteger minLength;
@property(nonatomic, readonly, assign, getter=isRequired) IBInspectable BOOL required;

- (instancetype)initWithMessage:(NSString*)message minLength:(NSInteger)minLength;

@end

/*--------------------------------------------------*/

@interface GLBInputMaxLengthValidator : NSObject < GLBInputValidator >

@property(nonatomic, strong) IBInspectable NSString* message;
@property(nonatomic) IBInspectable NSInteger maxLength;
@property(nonatomic, readonly, assign, getter=isRequired) IBInspectable BOOL required;

- (instancetype)initWithMessage:(NSString*)message maxLength:(NSInteger)maxLength;

@end

/*--------------------------------------------------*/

@interface GLBInputDigitValidator : NSObject < GLBInputValidator >

@property(nonatomic, strong) IBInspectable NSString* message;
@property(nonatomic, readonly, assign, getter=isRequired) IBInspectable BOOL required;

- (instancetype)initWithMessage:(NSString*)message;

@end

/*--------------------------------------------------*/

@interface GLBInputANDValidator : NSObject < GLBInputValidator >

@property(nonatomic, strong) IBOutletCollection(NSObject) NSArray* validators;

- (instancetype)initWithValidators:(NSArray*)validators;

@end

/*--------------------------------------------------*/

@interface GLBInputORValidator : NSObject < GLBInputValidator >

@property(nonatomic, strong) IBOutletCollection(NSObject) NSArray* validators;

- (instancetype)initWithValidators:(NSArray*)validators;

@end

/*--------------------------------------------------*/