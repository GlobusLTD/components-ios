/*--------------------------------------------------*/

#import "NSArray+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSArray (GLB_NS)

+ (instancetype)glb_arrayWithArray:(NSArray*)array addingObject:(id)object {
    NSMutableArray* result = [NSMutableArray arrayWithArray:array];
    [result addObject:object];
    return [NSArray arrayWithArray:result];
}

+ (instancetype)glb_arrayWithArray:(NSArray*)array addingObjectsFromArray:(NSArray*)addingObjects {
    NSMutableArray* result = [NSMutableArray arrayWithArray:array];
    [result addObjectsFromArray:addingObjects];
    return [NSArray arrayWithArray:result];
}

+ (instancetype)glb_arrayWithArray:(NSArray*)array removingObject:(id)object {
    NSMutableArray* result = [NSMutableArray arrayWithArray:array];
    [result removeObject:object];
    return [NSArray arrayWithArray:result];
}

+ (instancetype)glb_arrayWithArray:(NSArray*)array removingObjectsInArray:(NSArray*)removingObjects {
    NSMutableArray* result = [NSMutableArray arrayWithArray:array];
    [result removeObjectsInArray:removingObjects];
    return [NSArray arrayWithArray:result];
}

- (NSArray*)glb_arrayByReplaceObject:(id)object atIndex:(NSUInteger)index {
    NSMutableArray* result = [NSMutableArray arrayWithArray:self];
    result[index] = object;
    return [NSArray arrayWithArray:result];
}

- (NSArray*)glb_arrayByRemovedObjectAtIndex:(NSUInteger)index {
    NSMutableArray* result = [NSMutableArray arrayWithArray:self];
    [result removeObjectAtIndex:index];
    return [NSArray arrayWithArray:result];
}

- (NSArray*)glb_arrayByRemovedObject:(id)object {
    NSMutableArray* result = [NSMutableArray arrayWithArray:self];
    [result removeObject:object];
    return [NSArray arrayWithArray:result];
}

- (NSArray*)glb_arrayByRemovedObjectsFromArray:(NSArray*)array {
    NSMutableArray* result = [NSMutableArray arrayWithArray:self];
    [result removeObjectsInArray:array];
    return [NSArray arrayWithArray:result];
}

- (NSArray*)glb_arrayByObjectClass:(Class)objectClass {
    NSMutableArray* result = NSMutableArray.array;
    for(id object in self) {
        if([object isKindOfClass:objectClass]) {
            [result addObject:object];
        }
    }
    return [NSArray arrayWithArray:result];
}

- (NSArray*)glb_arrayByObjectProtocol:(Protocol*)objectProtocol {
    NSMutableArray* result = NSMutableArray.array;
    for(id object in self) {
        if([object conformsToProtocol:objectProtocol]) {
            [result addObject:object];
        }
    }
    return [NSArray arrayWithArray:result];
}

- (id)glb_firstObjectIsClass:(Class)objectClass {
    id result = nil;
    for(id object in self) {
        if([object isKindOfClass:objectClass]) {
            result = object;
            break;
        }
    }
    return result;
}

- (id)glb_lastObjectIsClass:(Class)objectClass {
    __block id result = nil;
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if([object isKindOfClass:objectClass]) {
            result = object;
            *stop = YES;
        }
    }];
    return result;
}

- (id)glb_firstObjectIsProtocol:(Protocol*)objectProtocol {
    id result = nil;
    for(id object in self) {
        if([object conformsToProtocol:objectProtocol]) {
            result = object;
            break;
        }
    }
    return result;
}

- (id)glb_lastObjectIsProtocol:(Protocol*)objectProtocol {
    __block id result = nil;
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if([object conformsToProtocol:objectProtocol]) {
            result = object;
            *stop = YES;
        }
    }];
    return result;
}

- (BOOL)glb_containsObjectsInArray:(NSArray*)objectsArray {
    for(id object in objectsArray) {
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
            continue;
        }
        block(object, index);
        index++;
    }
}

- (void)glb_each:(void(^)(id object))block options:(NSEnumerationOptions)options {
    [self enumerateObjectsWithOptions:options usingBlock:^(id object, NSUInteger index, BOOL* stop) {
        block(object);
    }];
}

- (void)glb_each:(void(^)(id object))block range:(NSRange)range options:(NSEnumerationOptions)options {
    [self enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range] options:options usingBlock:^(id object, NSUInteger index, BOOL* stop) {
        block(object);
    }];
}

- (void)glb_eachWithIndex:(void(^)(id object, NSUInteger index))block options:(NSEnumerationOptions)options {
    [self enumerateObjectsWithOptions:options usingBlock:^(id object, NSUInteger index, BOOL* stop) {
        block(object, index);
    }];
}

- (void)glb_eachWithIndex:(void(^)(id object, NSUInteger index))block range:(NSRange)range options:(NSEnumerationOptions)options {
    [self enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range] options:options usingBlock:^(id object, NSUInteger index, BOOL* stop) {
        block(object, index);
    }];
}

- (NSArray*)glb_duplicates:(id(^)(id object1, id object2))block {
    NSUInteger count = self.count;
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:count];
    for(NSUInteger i = 0; i < count; i++) {
        for(NSUInteger j = 0; j < count; j++) {
            if(i != j) {
                id object1 = self[i];
                id object2 = self[j];
                id duplicate = block(object1, object2);
                if(duplicate != nil) {
                    [result addObject:duplicate];
                }
            }
        }
    }
    return result.copy;
}

- (NSArray*)glb_map:(id(^)(id object))block {
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:self.count];
    NSArray* copied = self.copy;
    for(id object in copied) {
        id temp = block(object);
        if(temp != nil) {
            [array addObject:temp];
        }
    }
    return array;
}

- (NSDictionary*)glb_groupBy:(id(^)(id object))block {
    NSMutableDictionary* dictionary = NSMutableDictionary.dictionary;
    for(id object in self.copy) {
        id temp = block(object);
        if(dictionary[temp] != nil) {
            [dictionary[temp] addObject:object];
        } else {
            dictionary[temp] = [NSMutableArray arrayWithObject:object];
        }
    }
    return dictionary;
}

- (NSArray*)glb_select:(BOOL(^)(id object))block {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary* bindings) {
        return (block(evaluatedObject));
    }]];
}

- (NSArray*)glb_reject:(BOOL(^)(id object))block {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary* bindings) {
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

- (id)glb_find:(BOOL(^)(id object))block options:(NSEnumerationOptions)options {
    __block id result = nil;
    [self enumerateObjectsWithOptions:options usingBlock:^(id object, NSUInteger index, BOOL* stop) {
        if(block(object)) {
            result = object;
            *stop = YES;
        }
    }];
    return result;
}

- (id)glb_find:(BOOL(^)(id object))block  range:(NSRange)range options:(NSEnumerationOptions)options {
    __block id result = nil;
    [self enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range] options:options usingBlock:^(id object, NSUInteger index, BOOL* stop) {
        if(block(object)) {
            result = object;
            *stop = YES;
        }
    }];
    return result;
}

- (NSArray*)glb_reverse {
    return self.reverseObjectEnumerator.allObjects;
}

- (NSArray*)glb_intersectionWithArray:(NSArray*)array {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF IN %@", array]];
}

- (NSArray*)glb_intersectionWithArrays:(NSArray*)firstArray, ... {
    NSArray* resultArray = nil;
    if(firstArray != nil) {
        NSArray* eachArray = nil;
        resultArray = [self glb_intersectionWithArray:firstArray];
        va_list argumentList;
        va_start(argumentList, firstArray);
        while((eachArray = va_arg(argumentList, id)) != nil) {
            resultArray = [resultArray glb_intersectionWithArray:eachArray];
        }
        va_end(argumentList);
    } else {
        resultArray = @[];
    }
    return resultArray;
}

- (NSArray*)glb_unionWithArray:(NSArray*)array {
    return [[self glb_relativeComplement:array] arrayByAddingObjectsFromArray:array];
}

- (NSArray*)glb_unionWithArrays:(NSArray*)firstArray, ... {
    NSArray* resultArray = nil;
    if(firstArray != nil) {
        NSArray* eachArray = nil;
        resultArray = [self glb_unionWithArray:firstArray];
        va_list argumentList;
        va_start(argumentList, firstArray);
        while((eachArray = va_arg(argumentList, id)) != nil) {
            resultArray = [resultArray glb_unionWithArray:eachArray];
        }
        va_end(argumentList);
    } else {
        resultArray = @[];
    }
    return resultArray;
}

- (NSArray*)glb_relativeComplement:(NSArray*)array {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"NOT SELF IN %@", array]];
}

- (NSArray*)glb_relativeComplements:(NSArray*)firstArray, ... {
    NSArray* resultArray = nil;
    if(firstArray != nil) {
        NSArray* eachArray = nil;
        resultArray = [self glb_relativeComplement:firstArray];
        va_list argumentList;
        va_start(argumentList, firstArray);
        while((eachArray = va_arg(argumentList, id)) != nil) {
            resultArray = [resultArray glb_relativeComplement:eachArray];
        }
        va_end(argumentList);
    } else {
        resultArray = @[];
    }
    return resultArray;
}

- (NSArray*)glb_symmetricDifference:(NSArray*)array {
    NSArray* subA = [array glb_relativeComplement:self];
    NSArray* subB = [self glb_relativeComplement:array];
    return [subB glb_unionWithArray:subA];
}

#pragma mark - GLBObjectDebugProtocol

- (void)glb_debugString:(NSMutableString*)string context:(NSPointerArray*)context indent:(NSUInteger)indent root:(BOOL)root {
    if(root == YES) {
        [string glb_appendString:@"\t" repeat:indent];
    }
    NSUInteger baseIndent = indent + 1;
    [string appendString:@"[\n"];
    for(id object in self) {
        NSString* item = [object glb_debugContext:context indent:baseIndent root:NO];
        if(item != nil) {
            [string glb_appendString:@"\t" repeat:baseIndent];
            [string appendFormat:@"%@,\n", item];
        }
    }
    [string glb_appendString:@"\t" repeat:indent];
    [string appendString:@"]"];
}

@end

/*--------------------------------------------------*/

@implementation NSMutableArray (GLB_NS)

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
