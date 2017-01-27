/*--------------------------------------------------*/

#import "NSFileManager+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSFileManager (GLB_NS)

+ (NSString*)glb_documentDirectory {
    static NSString* directory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        if(directories.count > 0) {
            directory = directories.firstObject;
        }
    });
    return (directory != nil) ? directory : @"";
}

+ (NSString*)glb_libraryDirectory {
    static NSString* directory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* directories = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        if(directories.count > 0) {
            directory = directories.firstObject;
        }
    });
    return (directory != nil) ? directory : @"";
}

+ (NSString*)glb_cachesDirectory {
    static NSString* directory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* directories = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        if(directories.count > 0) {
            directory = directories.firstObject;
        }
    });
    return (directory != nil) ? directory : @"";
}

@end

/*--------------------------------------------------*/
