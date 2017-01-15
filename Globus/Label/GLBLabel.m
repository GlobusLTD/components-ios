/*--------------------------------------------------*/

#import "GLBLabel.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBLabelLink : NSObject

@property(nonatomic, readonly) NSRange range;
@property(nonatomic, readonly, strong) GLBTextStyle* normalStyle;
@property(nonatomic, readonly, strong) GLBTextStyle* highlightStyle;
@property(nonatomic, readonly, copy) GLBSimpleBlock pressed;

- (instancetype)initWithRange:(NSRange)range normalStyle:(GLBTextStyle*)normalStyle highlightStyle:(GLBTextStyle*)highlightStyle pressed:(GLBSimpleBlock)pressed;

@end

/*--------------------------------------------------*/

@interface GLBLabel () {
    NSMutableAttributedString* _attributed;
    NSMutableArray< GLBLabelLink* >* _links;
    NSMutableArray< GLBLabelLink* >* _hightlightedLinks;
}

@property(nonatomic, readonly, strong) NSLayoutManager* layoutManager;
@property(nonatomic, readonly, strong) NSTextContainer* textContainer;
@property(nonatomic, readonly, strong) NSTextStorage* textStorage;

@end

/*--------------------------------------------------*/

@implementation GLBLabel

#pragma mark - Synthesize

@synthesize pressGesture = _pressGesture;
@synthesize layoutManager = _layoutManager;
@synthesize textContainer = _textContainer;
@synthesize textStorage = _textStorage;

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
    _attributed = [NSMutableAttributedString new];
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:self.pressGesture];
}

- (void)dealloc {
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(_textContainer != nil) {
        _textContainer.size = self.bounds.size;
    }
}

#pragma mark - Property override

- (void)setText:(NSString*)text {
    if([_attributed.string isEqualToString:text] == NO) {
        [_attributed setAttributedString:[[NSAttributedString alloc] initWithString:text]];
        [self __updateAttributed];
    }
}

- (void)setAttributedText:(NSAttributedString*)attributedText {
    if([_attributed isEqualToAttributedString:attributedText] == NO) {
        [_attributed setAttributedString:attributedText];
        [self __updateAttributed];
    }
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    [super setLineBreakMode:lineBreakMode];
    if(_textContainer != nil) {
        _textContainer.lineBreakMode = lineBreakMode;
    }
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    [super setNumberOfLines:numberOfLines];
    if(_textContainer != nil) {
        _textContainer.maximumNumberOfLines = (NSUInteger)numberOfLines;
    }
}

#pragma mark - Property

- (UILongPressGestureRecognizer*)pressGesture {
    if(_pressGesture == nil) {
        _pressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__handlePressGesture)];
        _pressGesture.delaysTouchesBegan = YES;
        _pressGesture.minimumPressDuration = 0.01f;
    }
    return _pressGesture;
}

- (void)setTextStyle:(GLBTextStyle*)textStyle {
    _textStyle = textStyle;
    [self __updateAttributed];
}

#pragma mark - Property internal

- (NSLayoutManager*)layoutManager {
    if(_layoutManager == nil) {
        _layoutManager = [[NSLayoutManager alloc] init];
        [_layoutManager addTextContainer:self.textContainer];
        [self.textStorage addLayoutManager:_layoutManager];
    }
    return _layoutManager;
}

- (NSTextContainer*)textContainer {
    if(_textContainer == nil) {
        _textContainer = [[NSTextContainer alloc] initWithSize:self.bounds.size];
        _textContainer.lineFragmentPadding = 0.0;
        _textContainer.lineBreakMode = self.lineBreakMode;
        _textContainer.maximumNumberOfLines = (NSUInteger)self.numberOfLines;
    }
    return _textContainer;
}

- (NSTextStorage*)textStorage {
    if(_textStorage == nil) {
        _textStorage = [[NSTextStorage alloc] initWithAttributedString:self.attributedText];
    }
    return _textStorage;
}

#pragma mark - Public

- (NSRange)addLink:(NSString*)link normalStyle:(GLBTextStyle*)normalStyle pressed:(GLBSimpleBlock)pressed {
    return [self addLink:link normalStyle:normalStyle highlightStyle:nil pressed:pressed];
}

- (NSRange)addLink:(NSString*)link normalStyle:(GLBTextStyle*)normalStyle highlightStyle:(GLBTextStyle*)highlightStyle pressed:(GLBSimpleBlock)pressed {
    NSRange range = [_attributed.string rangeOfString:link];
    if((range.location != NSNotFound) && (range.length > 0)) {
        [self addLinkRange:range normalStyle:normalStyle highlightStyle:highlightStyle pressed:pressed];
    }
    return range;
}

- (void)addLinkRange:(NSRange)range normalStyle:(GLBTextStyle*)normalStyle pressed:(GLBSimpleBlock)pressed {
    [self addLinkRange:range normalStyle:normalStyle highlightStyle:nil pressed:pressed];
}

- (void)addLinkRange:(NSRange)range normalStyle:(GLBTextStyle*)normalStyle highlightStyle:(GLBTextStyle*)highlightStyle pressed:(GLBSimpleBlock)pressed {
    GLBLabelLink* link = [[GLBLabelLink alloc] initWithRange:range normalStyle:normalStyle highlightStyle:highlightStyle pressed:pressed];
    if(link != nil) {
        if(_links == nil) {
            _links = [NSMutableArray array];
        }
        [_links addObject:link];
        [self __updateAttributed];
    }
}

- (void)removeLinkRange:(NSRange)range {
    if(_links != nil) {
        NSIndexSet* indexSet = [_links indexesOfObjectsPassingTest:^BOOL(GLBLabelLink* link, NSUInteger index, BOOL* stop) {
            NSRange intersect = NSIntersectionRange(link.range, range);
            if((intersect.location != NSNotFound) && (intersect.length > 0)) {
                return YES;
            }
            return NO;
        }];
        if(indexSet.count > 0) {
            if(_hightlightedLinks != nil) {
                NSArray< GLBLabelLink* >* links = [_links objectsAtIndexes:indexSet];
                [_hightlightedLinks removeObjectsInArray:links];
                [_links removeObjectsInArray:links];
            } else {
                [_links removeObjectsAtIndexes:indexSet];
            }
            [self __updateAttributed];
        }
    }
}

- (void)removeLinkAllRanges {
    if(_links != nil) {
        [_links removeAllObjects];
        [self __updateAttributed];
    }
}

#pragma mark - Private

- (void)__updateAttributed {
    NSMutableAttributedString* result = [[NSMutableAttributedString alloc] initWithAttributedString:_attributed];
    if(_textStyle != nil) {
        [result setAttributes:_textStyle.attributes range:NSMakeRange(0, result.string.length)];
    }
    for(GLBLabelLink* link in _links) {
        if([_hightlightedLinks containsObject:link] == YES) {
            [result addAttributes:link.highlightStyle.attributes range:link.range];
        } else {
            [result addAttributes:link.normalStyle.attributes range:link.range];
        }
    }
    [super setAttributedText:result];
    if(_textStorage != nil) {
        [_textStorage setAttributedString:result];
    }
}

#pragma mark - Gestures

- (void)__handlePressGesture {
    CGPoint tapLocation = [_pressGesture locationInView:self];
    CGSize boundsSize = self.bounds.size;
    CGRect textBounds = [self.layoutManager usedRectForTextContainer:self.textContainer];
    CGPoint textOffset = CGPointMake((boundsSize.width - textBounds.size.width) * 0.5f - textBounds.origin.x,
                                     (boundsSize.height - textBounds.size.height) * 0.5f - textBounds.origin.y);
    CGPoint location = CGPointMake(tapLocation.x - textOffset.x, tapLocation.y - textOffset.y);
    NSUInteger pressedIndex = [self.layoutManager characterIndexForPoint:location inTextContainer:self.textContainer fractionOfDistanceBetweenInsertionPoints:nil];
    
    if(_hightlightedLinks == nil) {
        _hightlightedLinks = [NSMutableArray array];
    }
    NSIndexSet* indexSet = [_links indexesOfObjectsPassingTest:^BOOL(GLBLabelLink* link, NSUInteger index, BOOL* stop) {
        return NSLocationInRange(pressedIndex, link.range);
    }];
    NSArray< GLBLabelLink* >* links = [_links objectsAtIndexes:indexSet];
    switch(_pressGesture.state) {
        case UIGestureRecognizerStateEnded: {
            for(GLBLabelLink* link in links) {
                link.pressed();
            }
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            links = nil;
            break;
        default:
            break;
    }
    if([_hightlightedLinks isEqualToArray:links] == NO) {
        [_hightlightedLinks setArray:links];
        [self __updateAttributed];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    if((gestureRecognizer == _pressGesture) && (_links.count < 1)) {
        return NO;
    }
    return YES;
}

@end

/*--------------------------------------------------*/

@implementation GLBLabelLink

- (instancetype)initWithRange:(NSRange)range normalStyle:(GLBTextStyle*)normalStyle highlightStyle:(GLBTextStyle*)highlightStyle pressed:(GLBSimpleBlock)pressed {
    self = [super init];
    if(self != nil) {
        _range = range;
        _normalStyle = normalStyle;
        _highlightStyle = highlightStyle;
        _pressed = [pressed copy];
    }
    return self;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
