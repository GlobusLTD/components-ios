/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

typedef NS_ENUM(NSUInteger, GLBMoonPhase) {
    GLBMoonPhaseUnknown = NSNotFound,
    GLBMoonPhaseNewMoon = 0,
    GLBMoonPhaseEveningCrescent,
    GLBMoonPhaseFirstQuarter,
    GLBMoonPhaseWaxingGibbous,
    GLBMoonPhaseFullMoon,
    GLBMoonPhaseWaningGibbous,
    GLBMoonPhaseLastQuarter,
    GLBMoonPhaseMorningCrescent
};

/*--------------------------------------------------*/

typedef double GLBMoonDay;

/*--------------------------------------------------*/

@interface GLBMoon : NSObject

+ (GLBMoonDay)moonDayFromDate:(NSDate* _Nonnull)date;

+ (GLBMoonPhase)moonPhaseFromDate:(NSDate* _Nonnull)date;
+ (GLBMoonPhase)moonPhaseFromMoonDay:(GLBMoonDay)moonDay;

+ (NSString* _Nullable)moonPhaseStringFromDate:(NSDate* _Nonnull)date;
+ (NSString* _Nullable)moonPhaseStringFromPhase:(GLBMoonPhase)moonPhase;
+ (NSString* _Nullable)moonPhaseStringFromMoonDay:(GLBMoonDay)moonDay;

@end

/*--------------------------------------------------*/
