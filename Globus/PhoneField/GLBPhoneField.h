/*--------------------------------------------------*/

#import "GLBTextField.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBPhoneField : GLBTextField

@property(nonatomic, nullable, copy) NSString* prefix;
@property(nonatomic, nullable, readonly, strong) id userInfo;

- (void)setFormattedText:(nullable NSString*)text;

- (nullable NSString*)phoneNumberWithoutPrefix;
- (nullable NSString*)phoneNumber;

- (void)resetFormats;
- (void)resetDefaultFormat;

- (void)setDefaultOutputPattern:(nullable NSString*)pattern;
- (void)setDefaultOutputPattern:(nullable NSString*)pattern userInfo:(nullable id)userInfo;

- (void)addOutputPattern:(nonnull NSString*)pattern forRegExp:(nonnull NSString*)regexp;
- (void)addOutputPattern:(nonnull NSString*)pattern forRegExp:(nonnull NSString*)regexp userInfo:(nullable id)userInfo;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
