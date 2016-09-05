/****************************************************/
/*                                                  */
/* This file is part of the Globus Components iOS   */
/* Copyright 2014-2016 Globus-Ltd.                  */
/* http://www.globus-ltd.com                        */
/* Created by Alexander Trifonov                    */
/*                                                  */
/* For the full copyright and license information,  */
/* please view the LICENSE file that contained      */
/* MIT License and was distributed with             */
/* this source code.                                */
/*                                                  */
/****************************************************/

/*--------------------------------------------------*/

#import "NSSet+GLBNS.h"

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
        if([object isKindOfClass:objectClass] == YES) {
            [result addObject:object];
        }
    }
    return [NSSet setWithSet:result];
}

- (NSSet*)glb_setByObjectProtocol:(Protocol*)objectProtocol {
    NSMutableSet* result = NSMutableSet.set;
    for(id object in self) {
        if([object conformsToProtocol:objectProtocol] == YES) {
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
    typeof(self) copy = self.copy;
    for(id object in copy) {
        block(object);
    }
}

- (void)glb_each:(void(^)(id object))block options:(NSEnumerationOptions)options {
    typeof(self) copy = self.copy;
    [copy enumerateObjectsWithOptions:options usingBlock:^(id object, BOOL* stop) {
        block(object);
    }];
}

- (NSSet*)glb_map:(id(^)(id object))block {
    typeof(self) copy = self.copy;
    NSMutableSet* set = [NSMutableSet setWithCapacity:self.count];
    for(id object in copy) {
        id temp = block(object);
        if(temp != nil) {
            [set addObject:temp];
        }
    }
    return set;
}

- (NSDictionary*)glb_groupBy:(id(^)(id object))block {
    typeof(self) copy = self.copy;
    NSMutableDictionary* dictionary = NSMutableDictionary.dictionary;
    for(id object in copy) {
        id temp = block(object);
        if(dictionary[temp] != nil) {
            [dictionary[temp] addObject:object];
        } else {
            dictionary[temp] = [NSMutableSet setWithObject:object];
        }
    }
    return dictionary;
}

- (NSSet*)glb_select:(BOOL(^)(id object))block {
    typeof(self) copy = self.copy;
    return [copy filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary* bindings) {
        return (block(evaluatedObject));
    }]];
}

- (NSSet*)glb_reject:(BOOL(^)(id object))block {
    typeof(self) copy = self.copy;
    return [copy filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary* bindings) {
        return (block(evaluatedObject) == NO);
    }]];
}

- (id)glb_find:(BOOL(^)(id object))block {
    typeof(self) copy = self.copy;
    for(id object in copy) {
        if(block(object)) {
            return object;
        }
    }
    return nil;
}

@end

/*--------------------------------------------------*/

@implementation NSMutableSet (GLB_NS)
@end

/*--------------------------------------------------*/
