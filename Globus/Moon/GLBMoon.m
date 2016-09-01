/*--------------------------------------------------*/
//  http://www.cyberforum.ru/net-framework/thread932526.html
//  https://gist.github.com/L-A/3497902
/*--------------------------------------------------*/

#import "GLBMoon.h"

/*--------------------------------------------------*/

static double const edgeGLBMoonPhaseNewMoon = 1.84566;
static double const edgeGLBMoonPhaseEveningCrescent = 5.53699;
static double const edgeGLBMoonPhaseFirstQuarter = 9.22831;
static double const edgeGLBMoonPhaseWaxingGibbous = 12.91963;
static double const edgeGLBMoonPhaseFullMoon = 16.61096;
static double const edgeGLBMoonPhaseWaningGibbous = 20.30228;
static double const edgeGLBMoonPhaseLastQuarter = 23.99361;
static double const edgeGLBMoonPhaseMorningCrescent = 27.68493;

/*--------------------------------------------------*/

static double GLBMoonNormalize(double v) {
    v = v - GLB_FLOOR(v);
    if(v < 0) {
        v = v + 1;
    }
    return v;
}

/*--------------------------------------------------*/

@implementation GLBMoon

+ (GLBMoonDay)moonDayFromDate:(NSDate*)date; {
    if(date != nil) {
        static NSCalendar* gregorian = nil;
        if(gregorian == nil) {
            gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        }
        NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents* components = [gregorian components:units fromDate:date];
        int year = (int)components.year;
        int month = (int)components.month;
        int day = (int)components.day;
        double age;
        int yy, mm, k1, k2, k3, jd;
        double ip;
        yy = year - (int)GLB_ROUND((12.0 - month) / 10.0);
        mm = month + 9;
        if(mm >= 12) {
            mm = mm - 12;
        }
        k1 = (int)GLB_FLOOR(365.25 * (yy + 4712.0));
        k2 = (int)GLB_FLOOR(30.6 * mm + 0.5);
        k3 = (int)GLB_FLOOR(((yy / 100.0) + 49.0) * 0.75) - 38;
        jd = k1 + k2 + day + 59;
        if(jd > 2299160) {
            jd = jd - k3;
        }
        ip = GLBMoonNormalize((jd - 2451550.1) / 29.530588853);
        age = ip * 29.53;
        return age;
    }
    return -1;
}

+ (GLBMoonPhase)moonPhaseFromDate:(NSDate*)date {
    GLBMoonDay age = [GLBMoon moonDayFromDate:date];
    GLBMoonPhase moonPhase = [GLBMoon moonPhaseFromMoonDay:age];
    return moonPhase;
}

+ (GLBMoonPhase)moonPhaseFromMoonDay:(GLBMoonDay)moonDay {
    GLBMoonPhase moonPhase;
    if(moonDay < edgeGLBMoonPhaseNewMoon) {
        moonPhase = GLBMoonPhaseNewMoon;
    } else if(moonDay < edgeGLBMoonPhaseEveningCrescent) {
        moonPhase = GLBMoonPhaseEveningCrescent;
        return moonPhase;
    } else if(moonDay < edgeGLBMoonPhaseFirstQuarter) {
        moonPhase = GLBMoonPhaseFirstQuarter;
        return moonPhase;
    } else if(moonDay < edgeGLBMoonPhaseWaxingGibbous) {
        moonPhase = GLBMoonPhaseWaxingGibbous;
        return moonPhase;
    } else if(moonDay < edgeGLBMoonPhaseFullMoon) {
        moonPhase = GLBMoonPhaseFullMoon;
        return moonPhase;
    } else if(moonDay < edgeGLBMoonPhaseWaningGibbous) {
        moonPhase = GLBMoonPhaseWaningGibbous;
        return moonPhase;
    } else if(moonDay < edgeGLBMoonPhaseLastQuarter) {
        moonPhase = GLBMoonPhaseLastQuarter;
        return moonPhase;
    } else if(moonDay < edgeGLBMoonPhaseMorningCrescent) {
        moonPhase = GLBMoonPhaseMorningCrescent;
        return moonPhase;
    } else {
        moonPhase = GLBMoonPhaseNewMoon;
    }
    return moonPhase;
}

+(NSString*)moonPhaseStringFromPhase:(GLBMoonPhase)moonPhase {
    NSString* moonPhaseString = @"";
    switch(moonPhase) {
        case GLBMoonPhaseNewMoon: moonPhaseString = @"GLBMoonPhaseNewMoon"; break;
        case GLBMoonPhaseEveningCrescent: moonPhaseString = @"GLBMoonPhaseEveningCrescent"; break;
        case GLBMoonPhaseFirstQuarter: moonPhaseString = @"GLBMoonPhaseFirstQuarter"; break;
        case GLBMoonPhaseWaxingGibbous: moonPhaseString = @"GLBMoonPhaseWaxingGibbous"; break;
        case GLBMoonPhaseFullMoon: moonPhaseString = @"GLBMoonPhaseFullMoon"; break;
        case GLBMoonPhaseWaningGibbous: moonPhaseString = @"GLBMoonPhaseWaningGibbous"; break;
        case GLBMoonPhaseLastQuarter: moonPhaseString = @"GLBMoonPhaseLastQuarter"; break;
        case GLBMoonPhaseMorningCrescent: moonPhaseString = @"GLBMoonPhaseMorningCrescent"; break;
        default: break;
    }
    NSString* localized = [NSBundle.mainBundle localizedStringForKey:moonPhaseString value:@"Unknown" table:nil];
    if([localized isEqualToString:@"Unknown"] == YES) {
        localized = [GLBMoon.resourcesBundle localizedStringForKey:moonPhaseString value:moonPhaseString table:nil];
    }
    return localized;
}

+ (NSString*)moonPhaseStringFromDate:(NSDate*)date {
    GLBMoonPhase moonPhase = [GLBMoon moonPhaseFromDate:date];
    NSString *moonPhaseString = [GLBMoon moonPhaseStringFromPhase:moonPhase];
    return moonPhaseString;
}

+ (NSString*)moonPhaseStringFromMoonDay:(GLBMoonDay)moonDay {
    GLBMoonPhase moonPhase = [GLBMoon moonPhaseFromMoonDay:moonDay];
    NSString* moonPhaseString = [GLBMoon moonPhaseStringFromPhase:moonPhase];
    return moonPhaseString;
}

+ (NSBundle*)resourcesBundle {
    static NSBundle* resourcesBundle = nil;
    if(resourcesBundle == nil) {
        NSString* mainBundlePath = NSBundle.mainBundle.bundlePath;
        Class currentClass = self.class;
        while((resourcesBundle == nil) && (currentClass != nil)) {
            NSString* bundlePath = [NSString stringWithFormat:@"%@/%@.bundle", mainBundlePath, NSStringFromClass(currentClass)];
            resourcesBundle = [NSBundle bundleWithPath:bundlePath];
            currentClass = currentClass.superclass;
        }
        if(resourcesBundle == nil) {
            resourcesBundle = NSBundle.mainBundle;
        }
    }
    return resourcesBundle;
}

@end

/*--------------------------------------------------*/
