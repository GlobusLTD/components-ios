/*--------------------------------------------------*/

#import "GLBListField.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBListField () < UIPickerViewDataSource, UIPickerViewDelegate >

@property(nonatomic, strong) UIPickerView* pickerView;

@end

/*--------------------------------------------------*/

@implementation GLBListField

#pragma mark - Init / Free

#pragma mark - Public

- (void)didBeginEditing {
    [super didBeginEditing];
    
    if(_items.count > 0) {
        if(self.pickerView == nil) {
            self.pickerView = [UIPickerView new];
            self.pickerView.delegate = self;
            self.inputView = self.pickerView;
        }
        [self.pickerView reloadAllComponents];
        if(self.selectedItem != nil) {
            NSUInteger index = [_items indexOfObject:self.selectedItem];
            if(index != NSNotFound) {
                [self.pickerView selectRow:(NSInteger)(index) inComponent:0 animated:NO];
            }
        }
    } else {
        [self endEditing:YES];
    }
}

- (void)didEndEditing {
    [super didEndEditing];
    
    NSUInteger selectedItem = (NSUInteger)[self.pickerView selectedRowInComponent:0];
    if(selectedItem < _items.count) {
        [self setSelectedItem:_items[selectedItem] animated:YES emitted:YES];
    }
}

#pragma mark - Property

- (void)setItems:(NSArray*)items {
    if([_items isEqualToArray:items] == NO) {
        _items = items;
        
        if(self.isEditing == YES) {
            [self.pickerView reloadAllComponents];
        }
        if((self.selectedItem == nil) && (items.count > 0)) {
            self.selectedItem = items[0];
            self.text = self.selectedItem.title;
            if(self.isEditing == YES) {
                NSUInteger index = [_items indexOfObject:self.selectedItem];
                if(index != NSNotFound) {
                    [self.pickerView selectRow:(NSInteger)(index) inComponent:0 animated:NO];
                }
            }
        } else {
            self.text = @"";
        }
    }
}

- (void)setSelectedItem:(GLBListFieldItem*)selectedItem {
    [self setSelectedItem:selectedItem animated:NO emitted:NO];
}

- (void)setSelectedItem:(GLBListFieldItem*)selectedItem animated:(BOOL)animated {
    [self setSelectedItem:selectedItem animated:animated emitted:NO];
}

#pragma mark - Private

- (void)setSelectedItem:(GLBListFieldItem*)selectedItem animated:(BOOL)animated emitted:(BOOL)emitted {
    if(_selectedItem != selectedItem) {
        _selectedItem = selectedItem;
        
        if(selectedItem != nil) {
            self.text = selectedItem.title;
        } else {
            self.text = @"";
        }
        if(self.isEditing == YES) {
            NSUInteger index = [_items indexOfObject:self.selectedItem];
            if(index != NSNotFound) {
                [self.pickerView selectRow:(NSInteger)(index) inComponent:0 animated:NO];
            }
        }
        if(emitted == YES) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component {
    return (NSInteger)(_items.count);
}

#pragma mark - UIPickerViewDelegate

- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    GLBListFieldItem* listItem = _items[(NSUInteger)row];
    return listItem.title;
}

- (NSAttributedString*)pickerView:(UIPickerView*)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    GLBListFieldItem* listItem = _items[(NSUInteger)row];
    NSString* title = listItem.title;
    GLBTextStyle* style = listItem.style;
    if((title != nil) && (style != nil)) {
        return [[NSAttributedString alloc] initWithString:listItem.title attributes:style.attributes];
    }
    return nil;
}

- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self setSelectedItem:_items[(NSUInteger)row] animated:YES emitted:YES];
}

#pragma mark - GLBInputField

- (void)validate {
    if((self.form != nil) && (self.validator != nil)) {
        [self.form performValidator:self.validator value:self.selectedItem];
    }
}

- (NSArray*)messages {
    if((self.form != nil) && (self.validator != nil)) {
        return [self.validator messages:self.selectedItem];
    }
    return @[];
}

@end

/*--------------------------------------------------*/
#pragma mark -
/*--------------------------------------------------*/

@implementation GLBListFieldItem

#pragma mark - Not designated initializer

GLB_IMPLEMENTATION_NOT_DESIGNATED_INITIALIZER(init)

#pragma mark - Init / Free

+ (instancetype)itemWithTitle:(NSString*)title value:(id)value {
    return [[self alloc] initWithTitle:title value:value];
}

+ (instancetype)itemWithTitle:(NSString*)title style:(GLBTextStyle*)style value:(id)value {
    return [[self alloc] initWithTitle:title style:style value:value];
}

- (instancetype)initWithTitle:(NSString*)title value:(id)value {
    return [self initWithTitle:title style:nil value:value];
}

- (instancetype)initWithTitle:(NSString*)title style:(GLBTextStyle*)style value:(id)value {
    self = [super init];
    if(self != nil) {
        _title = title;
        _style = style;
        _value = value;
    }
    return self;
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
