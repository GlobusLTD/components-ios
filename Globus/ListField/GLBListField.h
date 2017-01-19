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

- (void)setSelectedItem:(GLBListFieldItem* _Nullable)selectedItem animated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@interface GLBListFieldItem : NSObject

@property(nonatomic, nonnull, strong) NSString* title;
@property(nonatomic, nullable, strong) GLBTextStyle* style;
@property(nonatomic, nullable, strong) id value;

+ (instancetype _Nonnull)new NS_UNAVAILABLE;
+ (instancetype _Nonnull)itemWithTitle:(NSString* _Nonnull)title value:(id _Nullable)value NS_SWIFT_UNAVAILABLE("Use init(title:value:)");
+ (instancetype _Nonnull)itemWithTitle:(NSString* _Nonnull)title style:(GLBTextStyle* _Nullable)style value:(id _Nullable)value NS_SWIFT_UNAVAILABLE("Use init(title:style:value:)");

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithTitle:(NSString* _Nonnull)title value:(id _Nullable)value;
- (instancetype _Nonnull)initWithTitle:(NSString* _Nonnull)title style:(GLBTextStyle* _Nullable)style value:(id _Nullable)value NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
