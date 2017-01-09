/*--------------------------------------------------*/

#import "GLBTextField.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBListFieldItem;

/*--------------------------------------------------*/

@interface GLBListField : GLBTextField

@property(nonatomic, nullable, strong) NSArray* items;
@property(nonatomic, nullable, strong) GLBListFieldItem* selectedItem;

- (void)setSelectedItem:(GLBListFieldItem* _Nullable)selectedItem animated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@interface GLBListFieldItem : NSObject

@property(nonatomic, nonnull, strong) NSString* title;
@property(nonatomic, nullable, strong) UIFont* font;
@property(nonatomic, nullable, strong) UIColor* color;
@property(nonatomic, nullable, strong) id value;

- (instancetype _Nonnull)init NS_UNAVAILABLE;
- (instancetype _Nonnull)initWithTitle:(NSString* _Nonnull)title value:(id _Nullable)value;
- (instancetype _Nonnull)initWithTitle:(NSString* _Nonnull)title color:(UIColor* _Nullable)color value:(id _Nullable)value;
- (instancetype _Nonnull)initWithTitle:(NSString* _Nonnull)title font:(UIFont* _Nullable)font color:(UIColor* _Nullable)color value:(id _Nullable)value NS_DESIGNATED_INITIALIZER;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
