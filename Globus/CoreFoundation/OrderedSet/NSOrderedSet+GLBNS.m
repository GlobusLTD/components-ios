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

#import "NSOrderedSet+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSOrderedSet (GLB_NS)

+ (instancetype)glb_orderedSetWithOrderedSet:(NSOrderedSet*)orderedSet addingObject:(id)object {
    NSMutableOrderedSet* result = [NSMutableOrderedSet orderedSetWithOrderedSet:orderedSet];
    [result addObject:object];
    return [NSOrderedSet orderedSetWithOrderedSet:result];
}

+ (instancetype)glb_orderedSetWithOrderedSet:(NSOrderedSet*)orderedSet addingObjectsFromOrderedSet:(NSOrderedSet*)addingObjects {
    NSMutableOrderedSet* result = [NSMutableOrderedSet orderedSetWithOrderedSet:orderedSet];
    for(id object in addingObjects) {
        [result addObject:object];
    }
    return [NSOrderedSet orderedSetWithOrderedSet:result];
}

+ (instancetype)glb_orderedSetWithOrderedSet:(NSOrderedSet*)orderedSet removingObject:(id)object {
    NSMutableOrderedSet* result = [NSMutableOrderedSet orderedSetWithOrderedSet:orderedSet];
    [result removeObject:object];
    return [NSOrderedSet orderedSetWithOrderedSet:result];
}

+ (instancetype)glb_orderedSetWithOrderedSet:(NSOrderedSet*)orderedSet removingObjectsInOrderedSet:(NSOrderedSet*)removingObjects {
    NSMutableOrderedSet* result = [NSMutableOrderedSet orderedSetWithOrderedSet:orderedSet];
    for(id object in removingObjects) {
        [result removeObject:object];
    }
    return [NSOrderedSet orderedSetWithOrderedSet:result];
}

- (NSOrderedSet*)glb_orderedSetByReplaceObject:(id)object atIndex:(NSUInteger)index {
    NSMutableOrderedSet* result = [NSMutableOrderedSet orderedSetWithOrderedSet:self];
    result[index] = object;
    return [NSOrderedSet orderedSetWithOrderedSet:result];
}

- (NSOrderedSet*)glb_orderedSetByRemovedObjectAtIndex:(NSUInteger)index {
    NSMutableOrderedSet* result = [NSMutableOrderedSet orderedSetWithOrderedSet:self];
    [result removeObjectAtIndex:index];
    return [NSOrderedSet orderedSetWithOrderedSet:result];
}

- (NSOrderedSet*)glb_orderedSetByRemovedObject:(id)object {
    NSMutableOrderedSet* result = [NSMutableOrderedSet orderedSetWithOrderedSet:self];
    [result removeObject:object];
    return [NSOrderedSet orderedSetWithOrderedSet:result];
}

- (NSOrderedSet*)glb_orderedSetByRemovedObjectsFromOrderedSet:(NSOrderedSet*)orderedSet {
    NSMutableOrderedSet* result = [NSMutableOrderedSet orderedSetWithOrderedSet:self];
    for(id object in orderedSet) {
        [result removeObject:object];
    }
    return [NSOrderedSet orderedSetWithOrderedSet:result];
}

- (NSOrderedSet*)glb_orderedSetByObjectClass:(Class)objectClass {
    NSMutableOrderedSet* result = NSMutableOrderedSet.orderedSet;
    for(id object in self) {
        if([object isKindOfClass:objectClass] == YES) {
            [result addObject:object];
        }
    }
    return [NSOrderedSet orderedSetWithOrderedSet:result];
}

- (NSOrderedSet*)glb_orderedSetByObjectProtocol:(Protocol*)objectProtocol {
    NSMutableOrderedSet* result = NSMutableOrderedSet.orderedSet;
    for(id object in self) {
        if([object conformsToProtocol:objectProtocol] == YES) {
            [result addObject:object];
        }
    }
    return [NSOrderedSet orderedSetWithOrderedSet:result];
}

- (id)glb_firstObjectIsClass:(Class)objectClass {
    id result = nil;
    for(id object in self) {
        if([object isKindOfClass:objectClass] == YES) {
            result = object;
            break;
        }
    }
    return result;
}

- (id)glb_lastObjectIsClass:(Class)objectClass {
    __block id result = nil;
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if([object isKindOfClass:objectClass] == YES) {
            result = object;
            *stop = YES;
        }
    }];
    return result;
}

- (id)glb_firstObjectIsProtocol:(Protocol*)objectProtocol {
    id result = nil;
    for(id object in self) {
        if([object conformsToProtocol:objectProtocol] == YES) {
            result = object;
            break;
        }
    }
    return result;
}

- (id)glb_lastObjectIsProtocol:(Protocol*)objectProtocol {
    __block id result = nil;
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if([object conformsToProtocol:objectProtocol] == YES) {
            result = object;
            *stop = YES;
        }
    }];
    return result;
}

- (BOOL)glb_containsObjectsInOrderedSet:(NSOrderedSet*)objectsOrderedSet {
    for(id object in objectsOrderedSet) {
        if([self containsObject:object] == NO) {
            return NO;
        }
    }
    return (self.count > 0);
}

- (NSUInteger)glb_nextIndexOfObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    if(index != NSNotFound) {
        if(index == self.count - 1) {
            index = NSNotFound;
        } else {
            index++;
        }
    }
    return index;
}

- (NSUInteger)glb_prevIndexOfObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    if(index != NSNotFound) {
        if(index == 0) {
            index = NSNotFound;
        } else {
            index--;
        }
    }
    return index;
}

- (id)glb_nextObjectOfObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    if(index != NSNotFound) {
        if(index < self.count - 1) {
            return self[index + 1];
        }
    }
    return nil;
}

- (id)glb_prevObjectOfObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    if(index != NSNotFound) {
        if(index != 0) {
            return self[index - 1];
        }
    }
    return nil;
}

- (void)glb_each:(void(^)(id object))block {
    typeof(self) copy = self.copy;
    for(id object in copy) {
        block(object);
    }
}

- (void)glb_each:(void(^)(id object))block range:(NSRange)range {
    typeof(self) copy = self.copy;
    NSUInteger index = 0;
    for(id object in copy) {
        if(NSLocationInRange(index, range) == NO) {
            index++;
            continue;
        }
        block(object);
        index++;
    }
}

- (void)glb_eachWithIndex:(void(^)(id object, NSUInteger index))block {
    typeof(self) copy = self.copy;
    NSUInteger index = 0;
    for(id object in copy) {
        block(object, index);
        index++;
    }
}

- (void)glb_eachWithIndex:(void(^)(id object, NSUInteger index))block range:(NSRange)range {
    typeof(self) copy = self.copy;
    NSUInteger index = 0;
    for(id object in copy) {
        if(NSLocationInRange(index, range) == NO) {
            index++;
            continue;
        }
        block(object, index);
        index++;
    }
}

- (void)glb_each:(void(^)(id object))block options:(NSEnumerationOptions)options {
    typeof(self) copy = self.copy;
    [copy enumerateObjectsWithOptions:options usingBlock:^(id object, NSUInteger index, BOOL* stop) {
        block(object);
    }];
}

- (void)glb_each:(void(^)(id object))block range:(NSRange)range options:(NSEnumerationOptions)options {
    typeof(self) copy = self.copy;
    [copy enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range] options:options usingBlock:^(id object, NSUInteger index, BOOL* stop) {
        block(object);
    }];
}

- (void)glb_eachWithIndex:(void(^)(id object, NSUInteger index))block options:(NSEnumerationOptions)options {
    typeof(self) copy = self.copy;
    [copy enumerateObjectsWithOptions:options usingBlock:^(id object, NSUInteger index, BOOL* stop) {
        block(object, index);
    }];
}

- (void)glb_eachWithIndex:(void(^)(id object, NSUInteger index))block range:(NSRange)range options:(NSEnumerationOptions)options {
    typeof(self) copy = self.copy;
    [copy enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range] options:options usingBlock:^(id object, NSUInteger index, BOOL* stop) {
        block(object, index);
    }];
}

- (NSOrderedSet*)glb_map:(id(^)(id object))block {
    typeof(self) copy = self.copy;
    NSMutableOrderedSet* orderedSet = [NSMutableOrderedSet orderedSetWithCapacity:copy.count];
    for(id object in copy) {
        id temp = block(object);
        if(temp != nil) {
            [orderedSet addObject:temp];
        }
    }
    return orderedSet;
}

- (NSDictionary*)glb_groupBy:(id(^)(id object))block {
    typeof(self) copy = self.copy;
    NSMutableDictionary* dictionary = NSMutableDictionary.dictionary;
    for(id object in copy) {
        id temp = block(object);
        if(dictionary[temp] != nil) {
            [dictionary[temp] addObject:object];
        } else {
            dictionary[temp] = [NSMutableOrderedSet orderedSetWithObject:object];
        }
    }
    return dictionary;
}

- (NSOrderedSet*)glb_select:(BOOL(^)(id object))block {
    typeof(self) copy = self.copy;
    return [copy filteredOrderedSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary* bindings) {
        return (block(evaluatedObject));
    }]];
}

- (NSOrderedSet*)glb_reject:(BOOL(^)(id object))block {
    typeof(self) copy = self.copy;
    return [copy filteredOrderedSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary* bindings) {
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

- (id)glb_find:(BOOL(^)(id object))block options:(NSEnumerationOptions)options {
    typeof(self) copy = self.copy;
    __block id result = nil;
    [copy enumerateObjectsWithOptions:options usingBlock:^(id object, NSUInteger index, BOOL* stop) {
        if(block(object)) {
            result = object;
            *stop = YES;
        }
    }];
    return result;
}

- (id)glb_find:(BOOL(^)(id object))block  range:(NSRange)range options:(NSEnumerationOptions)options {
    typeof(self) copy = self.copy;
    __block id result = nil;
    [copy enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range] options:options usingBlock:^(id object, NSUInteger index, BOOL* stop) {
        if(block(object)) {
            result = object;
            *stop = YES;
        }
    }];
    return result;
}

@end

/*--------------------------------------------------*/

@implementation NSMutableOrderedSet (GLB_NS)

- (void)glb_moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    id object = [self objectAtIndex:fromIndex];
    [self removeObjectAtIndex:fromIndex];
    [self insertObject:object atIndex:toIndex];
}

- (void)glb_removeFirstObjectsByCount:(NSUInteger)count {
    [self removeObjectsInRange:NSMakeRange(0, count)];
}

- (void)glb_removeLastObjectsByCount:(NSUInteger)count {
    [self removeObjectsInRange:NSMakeRange((self.count - 1) - count, count)];
}

@end

/*--------------------------------------------------*/
