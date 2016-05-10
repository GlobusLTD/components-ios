/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@interface GLBGrid : NSObject< NSCopying >

@property(nonatomic, readonly, assign) NSUInteger numberOfColumns;
@property(nonatomic, readonly, assign) NSUInteger numberOfRows;
@property(nonatomic, readonly, assign) NSUInteger count;

+ (instancetype)grid;
+ (instancetype)gridWithColumns:(NSUInteger)columns rows:(NSUInteger)rows;
+ (instancetype)gridWithColumns:(NSUInteger)columns rows:(NSUInteger)rows objects:(NSArray*)objects;
+ (instancetype)gridWithGrid:(GLBGrid*)grid;

- (instancetype)initWithColumns:(NSUInteger)columns rows:(NSUInteger)rows;
- (instancetype)initWithColumns:(NSUInteger)columns rows:(NSUInteger)rows objects:(NSArray*)objects;
- (instancetype)initWithGrid:(GLBGrid*)grid;

- (BOOL)containsObject:(id)object;
- (BOOL)containsColumn:(NSUInteger)column row:(NSUInteger)row;
- (BOOL)isEmptyColumn:(NSInteger)column;
- (BOOL)isEmptyRow:(NSInteger)row;

- (id)objectAtColumn:(NSUInteger)column atRow:(NSUInteger)row;
- (void)findObject:(id)object inColumn:(NSUInteger*)column inRow:(NSUInteger*)row;
- (void)findObjectUsingBlock:(BOOL(^)(id object))block inColumn:(NSUInteger*)column inRow:(NSUInteger*)row;
- (NSArray*)objects;

- (void)enumerateColumnsRowsUsingBlock:(void(^)(id object, NSUInteger column, NSUInteger row, BOOL* stopColumn, BOOL* stopRow))block;
- (void)enumerateRowsColumnsUsingBlock:(void(^)(id object, NSUInteger column, NSUInteger row, BOOL* stopColumn, BOOL* stopRow))block;
- (void)enumerateByColumn:(NSInteger)column usingBlock:(void(^)(id object, NSUInteger column, NSUInteger row, BOOL* stop))block;
- (void)enumerateByRow:(NSInteger)row usingBlock:(void(^)(id object, NSUInteger column, NSUInteger row, BOOL* stop))block;

- (void)eachColumnsRows:(void(^)(id object, NSUInteger column, NSUInteger row))block;
- (void)eachRowsColumns:(void(^)(id object, NSUInteger column, NSUInteger row))block;
- (void)each:(void(^)(id object, NSUInteger column, NSUInteger row))block byColumn:(NSInteger)column;
- (void)each:(void(^)(id object, NSUInteger column, NSUInteger row))block byRow:(NSInteger)row;

@end

/*--------------------------------------------------*/

@interface GLBMutableGrid : GLBGrid

- (void)setNumberOfColumns:(NSUInteger)numberOfColumns numberOfRows:(NSUInteger)numberOfRows;

- (void)setObject:(id)object atColumn:(NSUInteger)column atRow:(NSUInteger)row;
- (void)setObjects:(NSArray*)objects;

- (void)insertColumn:(NSUInteger)column objects:(NSArray*)objects;
- (void)insertRow:(NSUInteger)row objects:(NSArray*)objects;
- (void)removeColumn:(NSUInteger)column;
- (void)removeRow:(NSUInteger)row;
- (void)removeAllObjects;

@end

/*--------------------------------------------------*/
