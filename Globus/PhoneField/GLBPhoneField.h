/*--------------------------------------------------*/

#import "GLBTextField.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)

/*--------------------------------------------------*/

@interface GLBPhoneField : GLBTextField

@property(nonatomic, nullable, copy) NSString* prefix;
@property(nonatomic, nullable, readonly, strong) id userInfo;

- (void)setFormattedText:(NSString* _Nullable)text;

- (NSString* _Nullable)phoneNumberWithoutPrefix;
- (NSString* _Nullable)phoneNumber;

- (void)resetFormats;
- (void)resetDefaultFormat;

- (void)setDefaultOutputPattern:(NSString* _Nullable)pattern;
- (void)setDefaultOutputPattern:(NSString* _Nullable)pattern userInfo:(id _Nullable)userInfo;

- (void)addOutputPattern:(NSString* _Nonnull)pattern forRegExp:(NSString* _Nonnull)regexp;
- (void)addOutputPattern:(NSString* _Nonnull)pattern forRegExp:(NSString* _Nonnull)regexp userInfo:(id _Nullable)userInfo;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
