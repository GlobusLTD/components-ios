/*--------------------------------------------------*/

#import "GLBTextField.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)

/*--------------------------------------------------*/

@interface GLBPhoneField : GLBTextField

@property(nonatomic, copy) NSString* prefix;
@property(nonatomic, readonly, strong) id userInfo;

- (void)setFormattedText:(NSString*)text;

- (NSString*)phoneNumberWithoutPrefix;
- (NSString*)phoneNumber;

- (void)resetFormats;
- (void)resetDefaultFormat;

- (void)setDefaultOutputPattern:(NSString*)pattern;
- (void)setDefaultOutputPattern:(NSString*)pattern userInfo:(id)userInfo;

- (void)addOutputPattern:(NSString*)pattern forRegExp:(NSString*)regexp;
- (void)addOutputPattern:(NSString*)pattern forRegExp:(NSString*)regexp userInfo:(id)userInfo;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
