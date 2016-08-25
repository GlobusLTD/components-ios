/*--------------------------------------------------*/

#import "GLBListField.h"
#import "GLBInputForm.h"
#import "GLBInputValidator.h"

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
    
    if(self.items.count > 0) {
        if(self.pickerView == nil) {
            self.pickerView = [UIPickerView new];
            self.pickerView.delegate = self;
            self.inputView = self.pickerView;
        }
        [self.pickerView reloadAllComponents];
        if(self.selectedItem != nil) {
            NSUInteger index = [self.items indexOfObject:self.selectedItem];
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
    if(selectedItem < self.items.count) {
        [self setSelectedItem:self.items[selectedItem] animated:YES emitted:YES];
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
                NSUInteger index = [self.items indexOfObject:self.selectedItem];
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
            NSUInteger index = [self.items indexOfObject:self.selectedItem];
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
    return (NSInteger)(self.items.count);
}

#pragma mark - UIPickerViewDelegate

- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    GLBListFieldItem* listItem = self.items[(NSUInteger)row];
    return listItem.title;
}

- (NSAttributedString*)pickerView:(UIPickerView*)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    GLBListFieldItem* listItem = self.items[(NSUInteger)row];
    return [[NSAttributedString alloc] initWithString:[listItem title] attributes:@{
        NSFontAttributeName : [listItem font],
        NSForegroundColorAttributeName: [listItem color]
    }];
}

- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self setSelectedItem:self.items[(NSUInteger)row] animated:YES emitted:YES];
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

#pragma mark - Init / Free

- (instancetype)initWithTitle:(NSString*)title value:(id)value {
    self = [super init];
    if(self != nil) {
        _title = title;
        _font = [UIFont systemFontOfSize:UIFont.systemFontSize];
        _color = UIColor.blackColor;
        _value = value;
        [self setup];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString*)title color:(UIColor*)color value:(id)value {
    self = [super init];
    if(self != nil) {
        _title = title;
        _font = [UIFont systemFontOfSize:UIFont.systemFontSize];
        _color = color;
        _value = value;
        [self setup];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString*)title font:(UIFont*)font color:(UIColor*)color value:(id)value {
    self = [super init];
    if(self != nil) {
        _title = title;
        _font = font;
        _color = color;
        _value = value;
        [self setup];
    }
    return self;
}

- (void)setup {
}

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
