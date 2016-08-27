/*--------------------------------------------------*/

#import "NSBundle+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSBundle (GLB_NS)

- (id)glb_objectForInfoDictionaryKey:(NSString*)key defaultValue:(id)defaultValue {
    id value = [self objectForInfoDictionaryKey:key];
    if(value == nil) {
        return defaultValue;
    }
    return value;
}

@end

/*--------------------------------------------------*/
