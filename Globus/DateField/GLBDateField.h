/*--------------------------------------------------*/

#import "GLBTextField.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDateField : GLBTextField

@property(nonatomic) IBInspectable UIDatePickerMode datePickerMode;
@property(nonatomic, nullable, strong) IBInspectable NSDateFormatter* dateFormatter;
@property(nonatomic, nullable, strong) IBInspectable NSLocale* locale;
@property(nonatomic, nullable, strong) IBInspectable NSCalendar* calendar;
@property(nonatomic, nullable, strong) IBInspectable NSTimeZone* timeZone;
@property(nonatomic, nullable, strong) IBInspectable NSDate* minimumDate;
@property(nonatomic, nullable, strong) IBInspectable NSDate* maximumDate;
@property(nonatomic, nullable, strong) IBInspectable NSDate* date;

- (void)setDate:(NSDate* _Nullable)date animated:(BOOL)animated;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
