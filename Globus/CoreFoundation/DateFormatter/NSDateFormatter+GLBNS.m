/*--------------------------------------------------*/

#import "NSDateFormatter+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSDateFormatter (GLB_NS)

+ (instancetype)glb_dateFormatterWithFormat:(NSString*)format {
    return [self glb_dateFormatterWithFormat:format locale:NSLocale.currentLocale];
}

+ (instancetype)glb_dateFormatterWithFormat:(NSString*)format locale:(NSLocale*)locale {
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = format;
    dateFormatter.locale = locale;
    return dateFormatter;
}

+ (instancetype)glb_dateFormatterWithFormatTemplate:(NSString*)formatTemplate {
    return [self glb_dateFormatterWithFormatTemplate:formatTemplate locale:NSLocale.currentLocale];
}

+ (instancetype)glb_dateFormatterWithFormatTemplate:(NSString*)formatTemplate locale:(NSLocale*)locale {
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:formatTemplate options:0 locale:locale];
    dateFormatter.locale = locale;
    return dateFormatter;
}

@end

/*--------------------------------------------------*/
