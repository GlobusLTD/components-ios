/*--------------------------------------------------*/

#import "NSObject+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSObject (GLB_NS)

+ (NSString*)glb_className {
    return NSStringFromClass(self.class);
}

- (NSString*)glb_className {
    return NSStringFromClass(self.class);
}

- (BOOL)glb_isNull {
    return [self isKindOfClass:NSNull.class];
}

- (BOOL)glb_isNumber {
    return [self isKindOfClass:NSNumber.class];
}

- (BOOL)glb_isDecimalNumber {
    return [self isKindOfClass:NSDecimalNumber.class];
}

- (BOOL)glb_isString {
    return [self isKindOfClass:NSString.class];
}

- (BOOL)glb_isUrl {
    return [self isKindOfClass:NSURL.class];
}

- (BOOL)glb_isArray {
    return [self isKindOfClass:NSArray.class];
}

- (BOOL)glb_isSet {
    return [self isKindOfClass:NSSet.class];
}

- (BOOL)glb_isOrderedSet {
    return [self isKindOfClass:NSOrderedSet.class];
}

- (BOOL)glb_isDictionary {
    return [self isKindOfClass:NSDictionary.class];
}

- (BOOL)glb_isMutableArray {
    return [self isKindOfClass:NSMutableArray.class];
}

- (BOOL)glb_isMutableSet {
    return [self isKindOfClass:NSMutableSet.class];
}

- (BOOL)glb_isMutableOrderedSet {
    return [self isKindOfClass:NSMutableOrderedSet.class];
}

- (BOOL)glb_isMutableDictionary {
    return [self isKindOfClass:NSMutableDictionary.class];
}

@end

/*--------------------------------------------------*/
