/*--------------------------------------------------*/

#import "GLBDataContentView+Private.h"
#import "GLBDataViewCellCache.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@implementation GLBDataContentView

#pragma mark - Init / Free

- (instancetype)initWithCoder:(NSCoder*)coder {
    self = [super initWithCoder:coder];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.autoresizingMask = UIViewAutoresizingNone;
    self.translatesAutoresizingMaskIntoConstraints = YES;
    self.clipsToBounds = YES;
    
    _cells = [NSMutableDictionary dictionary];
    _layers = [NSMutableArray array];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(receiveMemoryWarning)
                                               name:UIApplicationDidReceiveMemoryWarningNotification
                                             object:nil];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    for(GLBDataContentLayerView* layer in _layers) {
        layer.frame = bounds;
    }
}

- (void)setClipsToBounds:(BOOL)clipsToBounds {
    [super setClipsToBounds:clipsToBounds];
    
    for(GLBDataContentLayerView* layer in _layers) {
        [layer setClipsToBounds:clipsToBounds];
    }
}

#pragma mark - Public

- (void)registerIdentifier:(NSString*)identifier withViewClass:(Class)viewClass {
    _cells[identifier] = viewClass;
}

- (void)unregisterIdentifier:(NSString*)identifier {
    [_cells removeObjectForKey:identifier];
}

- (void)unregisterAllIdentifiers {
    [_cells removeAllObjects];
}

- (Class)cellClassWithItem:(GLBDataViewItem*)item {
    return _cells[item.identifier];
}

- (Class)cellClassWithIdentifier:(NSString*)identifier {
    return _cells[identifier];
}

- (GLBDataContentLayerView*)layerWithItem:(GLBDataViewItem*)item {
    NSUInteger order = item.order;
    NSUInteger index = 0;
    GLBDataContentLayerView* layer = nil;
    if(_layers.count > 0) {
        for(GLBDataContentLayerView* existLayer in _layers) {
            if(existLayer.order == order) {
                layer = existLayer;
                break;
            }
        }
        if(layer == nil) {
            GLBDataContentLayerView* firstLayer = _layers.firstObject;
            GLBDataContentLayerView* lastObject = _layers.lastObject;
            if((firstLayer != nil) && (order < firstLayer.order)) {
                index = 0;
            } else if((lastObject != nil) && (order > lastObject.order)) {
                index = _layers.count;
            } else if(firstLayer != lastObject) {
                for(GLBDataContentLayerView* existLayer in _layers) {
                    if(existLayer.order > order) {
                        break;
                    }
                    index++;
                }
            }
        }
    }
    if(layer == nil) {
        layer = [[GLBDataContentLayerView alloc] initWithContentView:self order:order];
        if(layer != nil) {
            [self insertSubview:layer atIndex:(NSInteger)index];
            [_layers insertObject:layer atIndex:index];
        }
    }
    return layer;
}

- (GLBDataViewCell*)dequeueCellWithItem:(GLBDataViewItem*)item {
    GLBDataContentLayerView* layer = [self layerWithItem:item];
    if(layer == nil) {
        return nil;
    }
    GLBDataViewCell* cell = [layer dequeueCellWithIdentifier:item.identifier];
    if(cell != nil) {
        cell.dataView = _dataView;
    }
    return cell;
}

- (void)enqueueCell:(GLBDataViewCell*)cell item:(GLBDataViewItem*)item {
    GLBDataContentLayerView* layer = [self layerWithItem:item];
    if(layer != nil) {
        [layer enqueueCell:cell identifier:item.identifier];
    }
    cell.dataView = nil;
}

#pragma mark - Private

- (void)receiveMemoryWarning {
    for(GLBDataContentLayerView* layer in _layers) {
        [layer receiveMemoryWarning];
    }
}

@end

/*--------------------------------------------------*/

@implementation GLBDataContentLayerView

#pragma mark - Init / Free

- (instancetype)initWithContentView:(GLBDataContentView*)contentView order:(NSUInteger)order {
    self = [super initWithFrame:contentView.bounds];
    if(self != nil) {
        _contentView = contentView;
        _order = order;
        [self setup];
    }
    return self;
}

- (void)setup {
    self.translatesAutoresizingMaskIntoConstraints = _contentView.translatesAutoresizingMaskIntoConstraints;
    self.autoresizingMask = _contentView.autoresizingMask;
    self.clipsToBounds = _contentView.clipsToBounds;
    
    _cache = [NSMutableDictionary dictionary];
}

- (void)dealloc {
    [_cache glb_each:^(NSString* identifier, NSMutableArray< GLBDataViewCell* >* cache) {
        for(GLBDataViewCell* cell in cache) {
            [GLBDataViewCellCache.shared enqueueCell:cell];
        }
    }];
}

#pragma mark - UIView

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    UIView* view = [super hitTest:point withEvent:event];
    if(view == self) {
        view = nil;
    }
    return view;
}

#pragma mark - Public

- (GLBDataViewCell*)dequeueCellWithIdentifier:(NSString*)identifier {
    NSMutableArray< GLBDataViewCell* >* cache = _cache[identifier];
    GLBDataViewCell* cell = cache.lastObject;
    if(cell == nil) {
        Class cellClass = [_contentView cellClassWithIdentifier:identifier];
        if(cellClass != nil) {
            cell = [GLBDataViewCellCache.shared dequeueCellClass:cellClass];
        }
        if(cell != nil) {
            [self addSubview:cell];
        }
    } else {
        [cache removeLastObject];
    }
    return cell;
}

- (void)enqueueCell:(GLBDataViewCell*)cell identifier:(NSString*)identifier {
    NSMutableArray< GLBDataViewCell* >* cache = _cache[identifier];
    if(cache == nil) {
        _cache[identifier] = [NSMutableArray arrayWithObject:cell];
    } else {
        [cache addObject:cell];
    }
}

#pragma mark - Private

- (void)receiveMemoryWarning {
    [_cache removeAllObjects];
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
