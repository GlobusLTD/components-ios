/*--------------------------------------------------*/

#import "GLBTextField.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@class GLBListFieldItem;

/*--------------------------------------------------*/

@interface GLBListField : GLBTextField

@property(nonatomic, strong) NSArray* items;
@property(nonatomic, strong) GLBListFieldItem* selectedItem;

- (void)setSelectedItem:(GLBListFieldItem*)selectedItem animated:(BOOL)animated;

@end

/*--------------------------------------------------*/

@interface GLBListFieldItem : NSObject

@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) UIFont* font;
@property(nonatomic, strong) UIColor* color;
@property(nonatomic, strong) id value;

- (instancetype)initWithTitle:(NSString*)title value:(id)value;
- (instancetype)initWithTitle:(NSString*)title color:(UIColor*)color value:(id)value;
- (instancetype)initWithTitle:(NSString*)title font:(UIFont*)font color:(UIColor*)color value:(id)value;

- (void)setup NS_REQUIRES_SUPER;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
