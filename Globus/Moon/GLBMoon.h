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

+ (GLBMoonDay)moonDayFromDate:(nonnull NSDate*)date;

+ (GLBMoonPhase)moonPhaseFromDate:(nonnull NSDate*)date;
+ (GLBMoonPhase)moonPhaseFromMoonDay:(GLBMoonDay)moonDay;

+ (nullable NSString*)moonPhaseStringFromDate:(nonnull NSDate*)date;
+ (nullable NSString*)moonPhaseStringFromPhase:(GLBMoonPhase)moonPhase;
+ (nullable NSString*)moonPhaseStringFromMoonDay:(GLBMoonDay)moonDay;

@end

/*--------------------------------------------------*/
