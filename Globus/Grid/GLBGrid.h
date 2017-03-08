/*--------------------------------------------------*/

#include "GLBTargetConditionals.h"

/*--------------------------------------------------*/

@interface GLBGrid< __covariant ObjectType > : NSObject< NSCopying >

@property(nonatomic, readonly) NSUInteger numberOfColumns;
@property(nonatomic, readonly) NSUInteger numberOfRows;
@property(nonatomic, readonly) NSUInteger count;

+ (nonnull instancetype)grid NS_SWIFT_UNAVAILABLE("Use init()");
+ (nonnull instancetype)gridWithColumns:(NSUInteger)columns rows:(NSUInteger)rows NS_SWIFT_UNAVAILABLE("Use init(columns:rows:)");
+ (nonnull instancetype)gridWithColumns:(NSUInteger)columns rows:(NSUInteger)rows objects:(nullable NSArray< ObjectType >*)objects NS_SWIFT_UNAVAILABLE("Use init(columns:rows:objects:)");
+ (nonnull instancetype)gridWithGrid:(nonnull GLBGrid< ObjectType >*)grid NS_SWIFT_UNAVAILABLE("Use init(grid:)");

- (nonnull instancetype)initWithColumns:(NSUInteger)columns rows:(NSUInteger)rows;
- (nonnull instancetype)initWithColumns:(NSUInteger)columns rows:(NSUInteger)rows objects:(nullable NSArray< ObjectType >*)objects;
- (nonnull instancetype)initWithGrid:(nonnull GLBGrid< ObjectType >*)grid;

- (BOOL)containsObject:(nonnull id)object;
- (BOOL)containsColumn:(NSUInteger)column row:(NSUInteger)row;
- (BOOL)isEmptyColumn:(NSUInteger)column;
- (BOOL)isEmptyRow:(NSUInteger)row;

- (nullable id)objectAtColumn:(NSUInteger)column atRow:(NSUInteger)row;
- (void)findObject:(nullable id)object inColumn:(nullable NSUInteger*)column inRow:(nullable NSUInteger*)row;
- (void)findObjectUsingBlock:(BOOL(^ _Nonnull)(id _Nonnull object))block inColumn:(nullable NSUInteger*)column inRow:(nullable NSUInteger*)row;
- (nonnull NSArray< ObjectType >*)objects;

- (void)enumerateColumnsRowsUsingBlock:(void(^ _Nonnull)(id _Nonnull object, NSUInteger column, NSUInteger row, BOOL* _Nonnull stopColumn, BOOL* _Nonnull stopRow))block;
- (void)enumerateRowsColumnsUsingBlock:(void(^ _Nonnull)(id _Nonnull object, NSUInteger column, NSUInteger row, BOOL* _Nonnull stopColumn, BOOL* _Nonnull stopRow))block;
- (void)enumerateByColumn:(NSUInteger)column usingBlock:(void(^ _Nonnull)(id _Nonnull object, NSUInteger column, NSUInteger row, BOOL* _Nonnull stop))block;
- (void)enumerateByRow:(NSUInteger)row usingBlock:(void(^ _Nonnull)(id _Nonnull object, NSUInteger column, NSUInteger row, BOOL* _Nonnull stop))block;

- (void)eachColumnsRows:(void(^ _Nonnull)(id _Nonnull object, NSUInteger column, NSUInteger row))block;
- (void)eachRowsColumns:(void(^ _Nonnull)(id _Nonnull object, NSUInteger column, NSUInteger row))block;
- (void)each:(void(^ _Nonnull)(id _Nonnull object, NSUInteger column, NSUInteger row))block byColumn:(NSUInteger)column;
- (void)each:(void(^ _Nonnull)(id _Nonnull object, NSUInteger column, NSUInteger row))block byRow:(NSUInteger)row;

@end

/*--------------------------------------------------*/

@interface GLBMutableGrid< ObjectType > : GLBGrid

- (void)setNumberOfColumns:(NSUInteger)numberOfColumns numberOfRows:(NSUInteger)numberOfRows;

- (void)setObject:(nullable id)object atColumn:(NSUInteger)column atRow:(NSUInteger)row;
- (void)setObjects:(nullable NSArray< ObjectType >*)objects;

- (void)insertColumn:(NSUInteger)column objects:(nullable NSArray< ObjectType >*)objects;
- (void)insertRow:(NSUInteger)row objects:(nullable NSArray< ObjectType >*)objects;
- (void)removeColumn:(NSUInteger)column;
- (void)removeRow:(NSUInteger)row;
- (void)removeAllObjects;

@end

/*--------------------------------------------------*/
