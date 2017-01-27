/*--------------------------------------------------*/

#import "GLBGrid.h"

/*--------------------------------------------------*/

@interface GLBGrid () {
@protected
    NSUInteger _numberOfColumns;
    NSUInteger _numberOfRows;
    NSUInteger _count;
    NSMutableArray* _objects;
}

@property(nonatomic, readonly, copy) NSArray* columns;

@end

/*--------------------------------------------------*/

@implementation GLBGrid

#pragma mark - Synthesize

@synthesize numberOfColumns = _numberOfColumns;
@synthesize numberOfRows = _numberOfRows;
@synthesize count = _count;
@synthesize columns = _objects;

#pragma mark - Init / Free

+ (instancetype)grid {
    return [[self alloc] init];
}

+ (instancetype)gridWithColumns:(NSUInteger)columns rows:(NSUInteger)rows {
    return [[self alloc] initWithColumns:columns rows:rows];
}

+ (instancetype)gridWithColumns:(NSUInteger)columns rows:(NSUInteger)rows objects:(NSArray*)objects {
    return [[self alloc] initWithColumns:columns rows:rows objects:objects];
}

+ (instancetype)gridWithGrid:(GLBGrid*)grid {
    return [[self alloc] initWithGrid:grid];
}

- (instancetype)init {
    self = [super init];
    if(self != nil) {
        _objects = NSMutableArray.array;
    }
    return self;
}

- (instancetype)initWithColumns:(NSUInteger)columns rows:(NSUInteger)rows {
    self = [super init];
    if(self != nil) {
        _numberOfColumns = columns;
        _numberOfRows = rows;
        _count = _numberOfColumns * _numberOfRows;
        _objects = [NSMutableArray arrayWithCapacity:_numberOfColumns];
        for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
            NSMutableArray* columnObjects = [NSMutableArray arrayWithCapacity:_numberOfRows];
            for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
                [columnObjects addObject:[NSNull null]];
            }
            [_objects addObject:columnObjects];
        }
    }
    return self;
}

- (instancetype)initWithColumns:(NSUInteger)columns rows:(NSUInteger)rows objects:(NSArray*)objects {
    self = [super init];
    if(self != nil) {
        _numberOfColumns = columns;
        _numberOfRows = rows;
        _count = _numberOfColumns * _numberOfRows;
        _objects = [NSMutableArray arrayWithCapacity:_numberOfColumns];
        if(objects.count > 0) {
            NSUInteger index = 0;
            for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
                NSMutableArray* columnObjects = [NSMutableArray arrayWithCapacity:_numberOfRows];
                for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
                    if(index < objects.count) {
                        [columnObjects addObject:objects[index]];
                    } else {
                        [columnObjects addObject:[NSNull null]];
                    }
                    index++;
                }
                [_objects addObject:columnObjects];
            }
        }
    }
    return self;
}

- (instancetype)initWithGrid:(GLBGrid*)grid {
    self = [super init];
    if(self != nil) {
        _numberOfColumns = grid.numberOfColumns;
        _numberOfRows = grid.numberOfRows;
        _count = grid.count;
        _objects = [NSMutableArray arrayWithArray:grid.columns];
    }
    return self;
}

- (void)dealloc {
    _objects = nil;
}

#pragma mark - Public

- (BOOL)containsObject:(id)object {
    for(NSMutableArray* columnObjects in _objects) {
        if([columnObjects containsObject:object] == YES) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)containsColumn:(NSUInteger)column row:(NSUInteger)row {
    return ([_objects[column][row] isKindOfClass:NSNull.class] == NO);
}

- (BOOL)isEmptyColumn:(NSUInteger)column {
    for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
        if([_objects[column][ir] isKindOfClass:NSNull.class] == NO) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isEmptyRow:(NSUInteger)row {
    for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
        if([_objects[ic][row] isKindOfClass:NSNull.class] == NO) {
            return NO;
        }
    }
    return YES;
}

- (id)objectAtColumn:(NSUInteger)column atRow:(NSUInteger)row {
    id object = _objects[column][row];
    if([object isKindOfClass:NSNull.class] == YES) {
        return nil;
    }
    return object;
}

- (void)findObject:(id)object inColumn:(NSUInteger*)column inRow:(NSUInteger*)row {
    [self findObjectUsingBlock:^BOOL(id exist) { return [exist isEqual:object]; } inColumn:column inRow:row];
}

- (void)findObjectUsingBlock:(BOOL(^)(id object))block inColumn:(NSUInteger*)column inRow:(NSUInteger*)row {
    for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
        NSMutableArray* columnObjects = _objects[ic];
        for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
            if(block(columnObjects[ir]) == YES) {
                if(column != NULL) {
                    *column = ic;
                }
                if(row != NULL) {
                    *row = ir;
                }
                return;
            }
        }
    }
    if(column != NULL) {
        *column = NSNotFound;
    }
    if(row != NULL) {
        *row = NSNotFound;
    }
}

- (NSArray*)objects {
    NSMutableArray* result = [NSMutableArray array];
    for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
        NSMutableArray* columnObjects = _objects[ic];
        for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
            [result addObject:columnObjects[ir]];
        }
    }
    return result;
}

- (void)enumerateColumnsRowsUsingBlock:(void(^)(id object, NSUInteger column, NSUInteger row, BOOL* stopColumn, BOOL* stopRow))block {
    for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
        BOOL stopColumn = NO;
        NSMutableArray* columnObjects = _objects[ic];
        for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
            BOOL stopRow = NO;
            block(columnObjects[ir], ic, ir, &stopColumn, &stopRow);
            if(stopRow == YES) {
                break;
            }
        }
        if(stopColumn == YES) {
            break;
        }
    }
}

- (void)enumerateRowsColumnsUsingBlock:(void(^)(id object, NSUInteger column, NSUInteger row, BOOL* stopColumn, BOOL* stopRow))block {
    for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
        BOOL stopRow = NO;
        for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
            BOOL stopColumn = NO;
            block(_objects[ic][ir], ic, ir, &stopColumn, &stopRow);
            if(stopColumn == YES) {
                break;
            }
        }
        if(stopRow == YES) {
            break;
        }
    }
}

- (void)enumerateByColumn:(NSUInteger)column usingBlock:(void(^)(id object, NSUInteger column, NSUInteger row, BOOL* stop))block {
    NSMutableArray* columnObjects = _objects[column];
    for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
        BOOL stop = NO;
        block(columnObjects[ir], column, ir, &stop);
        if(stop == YES) {
            break;
        }
    }
}

- (void)enumerateByRow:(NSUInteger)row usingBlock:(void(^)(id object, NSUInteger column, NSUInteger row, BOOL* stop))block {
    for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
        BOOL stop = NO;
        block(_objects[ic][row], ic, row, &stop);
        if(stop == YES) {
            break;
        }
    }
}

- (void)eachColumnsRows:(void(^)(id object, NSUInteger column, NSUInteger row))block {
    for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
        NSMutableArray* columnObjects = _objects[ic];
        for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
            block(columnObjects[ir], ic, ir);
        }
    }
}

- (void)eachRowsColumns:(void(^)(id object, NSUInteger column, NSUInteger row))block {
    for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
        for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
            block(_objects[ic][ir], ic, ir);
        }
    }
}

- (void)each:(void(^)(id object, NSUInteger column, NSUInteger row))block byColumn:(NSUInteger)column {
    NSMutableArray* columnObjects = _objects[column];
    for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
        block(columnObjects[ir], column, ir);
    }
}

- (void)each:(void(^)(id object, NSUInteger column, NSUInteger row))block byRow:(NSUInteger)row {
    for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
        block(_objects[ic][row], ic, row);
    }
}

#pragma mark - NSCopying

- (id)copy {
    return [self copyWithZone:NSDefaultMallocZone()];
}

- (id)copyWithZone:(NSZone*)zone {
    return [[GLBGrid allocWithZone:zone] initWithGrid:self];
}

- (id)mutableCopy {
    return [self mutableCopyWithZone:NSDefaultMallocZone()];
}

- (id)mutableCopyWithZone:(NSZone*)zone {
    return [[GLBMutableGrid allocWithZone:zone] initWithGrid:self];
}

@end

/*--------------------------------------------------*/

@implementation GLBMutableGrid

#pragma mark - Public

- (void)setNumberOfColumns:(NSUInteger)numberOfColumns numberOfRows:(NSUInteger)numberOfRows {
    if((_numberOfColumns != numberOfColumns) || (_numberOfRows != numberOfRows)) {
        _numberOfColumns = numberOfColumns;
        _numberOfRows = numberOfRows;
        _count = _numberOfColumns * _numberOfRows;
        [_objects removeAllObjects];
        for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
            NSMutableArray* columnObjects = [NSMutableArray arrayWithCapacity:_numberOfRows];
            for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
                [columnObjects addObject:[NSNull null]];
            }
            [_objects addObject:columnObjects];
        }
    }
}

- (void)setObject:(id)object atColumn:(NSUInteger)column atRow:(NSUInteger)row {
    _objects[column][row] = (object != nil) ? object : [NSNull null];
}

- (void)setObjects:(NSArray*)objects {
    [_objects removeAllObjects];
    NSUInteger index = 0;
    for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
        NSMutableArray* columnObjects = [NSMutableArray arrayWithCapacity:_numberOfRows];
        for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
            if(index < objects.count) {
                [columnObjects addObject:objects[index]];
            } else {
                [columnObjects addObject:[NSNull null]];
            }
            index++;
        }
        [_objects addObject:columnObjects];
    }
}

- (void)insertColumn:(NSUInteger)column objects:(NSArray*)objects {
    NSMutableArray* columnObjects = [NSMutableArray arrayWithCapacity:_numberOfRows];
    for(NSUInteger ir = 0; ir < _numberOfRows; ir++) {
        if(ir < objects.count) {
            [columnObjects addObject:objects[ir]];
        } else {
            [columnObjects addObject:[NSNull null]];
        }
    }
    [_objects insertObject:columnObjects atIndex:column];
    _numberOfColumns++;
    _count = _numberOfColumns * _numberOfRows;
}

- (void)insertRow:(NSUInteger)row objects:(NSArray*)objects {
    for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
        if(ic < objects.count) {
            [_objects[ic] insertObject:objects[ic] atIndex:row];
        } else {
            [_objects[ic] insertObject:[NSNull null] atIndex:row];
        }
    }
    _numberOfRows--;
    _count = _numberOfColumns * _numberOfRows;
}

- (void)removeColumn:(NSUInteger)column {
    [_objects removeObjectAtIndex:column];
    _numberOfColumns--;
    _count = _numberOfColumns * _numberOfRows;
}

- (void)removeRow:(NSUInteger)row {
    for(NSUInteger ic = 0; ic < _numberOfColumns; ic++) {
        [_objects[ic] removeObjectAtIndex:row];
    }
    _numberOfRows--;
    _count = _numberOfColumns * _numberOfRows;
}

- (void)removeAllObjects {
    [_objects removeAllObjects];
    _numberOfColumns = 0;
    _numberOfRows = 0;
    _count = 0;
}

@end

/*--------------------------------------------------*/
