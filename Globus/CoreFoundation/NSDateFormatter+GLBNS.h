/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@interface NSDateFormatter (GLB_NS) < GLBObjectDebugProtocol >

+ (_Nullable instancetype)glb_dateFormatterWithFormat:(NSString* _Nonnull)format;
+ (_Nullable instancetype)glb_dateFormatterWithFormat:(NSString* _Nonnull)format locale:(NSLocale* _Nullable)locale;
+ (_Nullable instancetype)glb_dateFormatterWithFormatTemplate:(NSString* _Nonnull)formatTemplate;
+ (_Nullable instancetype)glb_dateFormatterWithFormatTemplate:(NSString* _Nonnull)formatTemplate locale:(NSLocale* _Nullable)locale;

@end

/*--------------------------------------------------*/
