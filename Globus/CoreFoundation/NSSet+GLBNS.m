/*--------------------------------------------------*/

#import "NSSet+GLBNS.h"
#import "NSDictionary+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSSet (GLB_NS)

+ (instancetype)glb_setWithSet:(NSSet*)set addingObject:(id)object {
    NSMutableSet* result = [NSMutableSet setWithSet:set];
    [result addObject:object];
    return [NSSet setWithSet:result];
}

+ (instancetype)glb_setWithSet:(NSSet*)set addingObjectsFromSet:(NSSet*)addingObjects {
    NSMutableSet* result = [NSMutableSet setWithSet:set];
    for(id object in addingObjects) {
        [result addObject:object];
    }
    return [NSSet setWithSet:result];
}

+ (instancetype)glb_setWithSet:(NSSet*)set removingObject:(id)object {
    NSMutableSet* result = [NSMutableSet setWithSet:set];
    [result removeObject:object];
    return [NSSet setWithSet:result];
}

+ (instancetype)glb_setWithSet:(NSSet*)set removingObjectsInSet:(NSSet*)removingObjects {
    NSMutableSet* result = [NSMutableSet setWithSet:set];
    for(id object in removingObjects) {
        [result removeObject:object];
    }
    return [NSSet setWithSet:result];
}

- (NSSet*)glb_setByRemovedObject:(id)object {
    NSMutableSet* result = [NSMutableSet setWithSet:self];
    [result removeObject:object];
    return [NSSet setWithSet:result];
}

- (NSSet*)glb_setByRemovedObjectsFromSet:(NSSet*)set {
    NSMutableSet* result = [NSMutableSet setWithSet:self];
    for(id object in set) {
        [result removeObject:object];
    }
    return [NSSet setWithSet:result];
}

- (NSSet*)glb_setByObjectClass:(Class)objectClass {
    NSMutableSet* result = NSMutableSet.set;
    for(id object in self) {
        if([object isKindOfClass:objectClass]) {
            [result addObject:object];
        }
    }
    return [NSSet setWithSet:result];
}

- (NSSet*)glb_setByObjectProtocol:(Protocol*)objectProtocol {
    NSMutableSet* result = NSMutableSet.set;
    for(id object in self) {
        if([object conformsToProtocol:objectProtocol]) {
            [result addObject:object];
        }
    }
    return [NSSet setWithSet:result];
}

- (BOOL)glb_containsObjectsInSet:(NSSet*)objectsSet {
    for(id object in objectsSet) {
        if([self containsObject:object] == NO) {
            return NO;
        }
    }
    return (self.count > 0);
}

- (void)glb_each:(void(^)(id object))block {
    [self enumerateObjectsUsingBlock:^(id object, BOOL* stop) {
        block(object);
    }];
}

- (void)glb_each:(void(^)(id object))block options:(NSEnumerationOptions)options {
    [self enumerateObjectsWithOptions:options usingBlock:^(id object, BOOL* stop) {
        block(object);
    }];
}

- (NSSet*)glb_map:(id(^)(id object))block {
    NSMutableSet* set = [NSMutableSet setWithCapacity:self.count];
    for(id object in self) {
        id temp = block(object);
        if(temp != nil) {
            [set addObject:temp];
        }
    }
    return set;
}

- (NSDictionary*)glb_groupBy:(id(^)(id object))block {
    NSMutableDictionary* dictionary = NSMutableDictionary.dictionary;
    for(id object in self) {
        id temp = block(object);
        if([dictionary glb_hasKey:temp]) {
            [dictionary[temp] addObject:object];
        } else {
            dictionary[temp] = [NSMutableSet setWithObject:object];
        }
    }
    return dictionary;
}

- (NSSet*)glb_select:(BOOL(^)(id object))block {
    return [self filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary* bindings) {
        return (block(evaluatedObject));
    }]];
}

- (NSSet*)glb_reject:(BOOL(^)(id object))block {
    return [self filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary* bindings) {
        return (block(evaluatedObject) == NO);
    }]];
}

- (id)glb_find:(BOOL(^)(id object))block {
    for(id object in self) {
        if(block(object)) {
            return object;
        }
    }
    return nil;
}

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendString:@"(\n"];
    for(id object in self) {
        [string glb_appendString:@"\t" repeat:baseIndent];
        [string appendFormat:@"%@,\n", [object glb_debugIndent:baseIndent root:NO]];
    }
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@")"];
}

@end

/*--------------------------------------------------*/

@implementation NSMutableSet (GLB_NS)
@end

/*--------------------------------------------------*/
