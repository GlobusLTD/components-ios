/*--------------------------------------------------*/

#import "GLBTextField.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBListFieldItem;

/*--------------------------------------------------*/

@interface GLBListField : GLBTextField

@property(nonatomic, nullable, strong) NSArray< GLBListFieldItem* >* items;
@property(nonatomic, nullable, strong) GLBListFieldItem* selectedItem;

- (void)setSelectedItem:(nullable GLBListFieldItem*)selectedItem animated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@interface GLBListFieldItem : NSObject

@property(nonatomic, nonnull, strong) NSString* title;
@property(nonatomic, nullable, strong) GLBTextStyle* style;
@property(nonatomic, nullable, strong) id value;

+ (nonnull instancetype)new NS_UNAVAILABLE;
+ (nonnull instancetype)itemWithTitle:(nonnull NSString*)title value:(nullable id)value NS_SWIFT_UNAVAILABLE("Use init(title:value:)");
+ (nonnull instancetype)itemWithTitle:(nonnull NSString*)title style:(nullable GLBTextStyle*)style value:(nullable id)value NS_SWIFT_UNAVAILABLE("Use init(title:style:value:)");

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithTitle:(nonnull NSString*)title value:(nullable id)value;
- (nonnull instancetype)initWithTitle:(nonnull NSString*)title style:(nullable GLBTextStyle*)style value:(nullable id)value NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
