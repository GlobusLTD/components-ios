/*--------------------------------------------------*/

#import <Foundation/Foundation.h>

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

+ (GLBMoonDay)moonDayFromDate:(NSDate*)date;

+ (GLBMoonPhase)moonPhaseFromDate:(NSDate*)date;
+ (GLBMoonPhase)moonPhaseFromMoonDay:(GLBMoonDay)moonDay;

+ (NSString*)moonPhaseStringFromDate:(NSDate*)date;
+ (NSString*)moonPhaseStringFromPhase:(GLBMoonPhase)moonPhase;
+ (NSString*)moonPhaseStringFromMoonDay:(GLBMoonDay)moonDay;

@end

/*--------------------------------------------------*/
