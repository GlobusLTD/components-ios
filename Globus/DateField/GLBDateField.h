/*--------------------------------------------------*/

#import "GLBTextField.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDateField : GLBTextField

@property(nonatomic) IBInspectable UIDatePickerMode datePickerMode;
@property(nonatomic, strong) IBInspectable NSDateFormatter* dateFormatter;
@property(nonatomic, strong) IBInspectable NSLocale* locale;
@property(nonatomic, copy) IBInspectable NSCalendar* calendar;
@property(nonatomic, strong) IBInspectable NSTimeZone* timeZone;
@property(nonatomic, strong) IBInspectable NSDate* minimumDate;
@property(nonatomic, strong) IBInspectable NSDate* maximumDate;
@property(nonatomic, strong) IBInspectable NSDate* date;

- (void)setDate:(NSDate*)date animated:(BOOL)animated;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
