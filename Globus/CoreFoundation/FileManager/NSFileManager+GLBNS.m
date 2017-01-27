/*--------------------------------------------------*/

#import "NSFileManager+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSFileManager (GLB_NS)

+ (NSString*)glb_documentDirectory {
    static NSString* result = nil;
    if(result == nil) {
        NSArray* directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        if(directories.count > 0) {
            result = directories.firstObject;
        }
    }
    return (result != nil) ? result : @"";
}

+ (NSString*)glb_libraryDirectory {
    static NSString* result = nil;
    if(result == nil) {
        NSArray* directories = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        if(directories.count > 0) {
            result = directories.firstObject;
        }
    }
    return (result != nil) ? result : @"";
}

+ (NSString*)glb_cachesDirectory {
    static NSString* result = nil;
    if(result == nil) {
        NSArray* directories = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        if(directories.count > 0) {
            result = directories.firstObject;
        }
    }
    return (result != nil) ? result : @"";
}

@end

/*--------------------------------------------------*/
