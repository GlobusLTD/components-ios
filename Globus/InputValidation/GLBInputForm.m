/*--------------------------------------------------*/

#import "GLBInputForm.h"
#import "GLBInputField.h"
#import "GLBInputValidator.h"

/*--------------------------------------------------*/

#import "GLBAction.h"
#import "NSArray+GLBNS.h"
#import "NSString+GLBNS.h"

/*--------------------------------------------------*/

@interface GLBInputForm ()

@property(nonatomic, strong) NSMutableSet* validatedFields;

@end

/*--------------------------------------------------*/

@implementation GLBInputForm

#pragma mark - Property

- (void)setFields:(NSArray*)fields {
    NSMutableArray* checkedFields = [NSMutableArray array];
    for(id field in fields) {
        if([field conformsToProtocol:@protocol(GLBInputField)]) {
            [checkedFields addObject:field];
        }
    }
    if([_fields isEqualToArray:checkedFields] == NO) {
        for(id< GLBInputField > field in _fields) {
            field.form = nil;
        }
        _fields = checkedFields;
        for(id< GLBInputField > field in _fields) {
            field.form = self;
        }
        _validatedFields = [NSMutableSet set];
    }
}

- (void)setValid:(BOOL)valid {
    if(_valid != valid) {
        _valid = valid;
        [_actionChangeState performWithArguments:@[ self, @(valid) ]];
    }
}

#pragma mark - Public

- (void)addField:(id< GLBInputField >)field {
    if(([_fields containsObject:field] == NO) && (field.form == nil)) {
        _fields = [NSArray glb_arrayWithArray:_fields addingObject:field];
        [_validatedFields addObject:field];
        field.form = self;
    }
}

- (void)removeField:(id< GLBInputField >)field {
    if(([_fields containsObject:field] == YES) && (field.form == self)) {
        _fields = [NSArray glb_arrayWithArray:_fields removingObject:field];
        field.form = nil;
    }
}

- (void)removeAllFields {
    for(id< GLBInputField > field in _fields) {
        field.form = nil;
    }
    _fields = @[];
}

- (NSArray*)invalidFields {
    return [_fields glb_relativeComplement:[_validatedFields allObjects]];
}

- (NSString*)output {
    __block NSString* output = @"";
    NSArray* results = @[];
    NSArray* invalidFields = self.invalidFields;
    for(id< GLBInputField > field in invalidFields) {
        results = [results glb_unionWithArray:[field messages]];
    }
    [results glb_eachWithIndex:^(NSString* r, NSUInteger index) {
        output = [output stringByAppendingString:r];
        if(index != results.count-1) {
            output = [output stringByAppendingString:@"\n"];
        }
    }];
    return output;
}

- (void)performValidator:(id< GLBInputValidator >)validator value:(id)value {
    if([validator validate:value] == YES) {
        [_validatedFields addObject:validator.field];
    } else {
        [_validatedFields removeObject:validator.field];
    }
    _valid = (_fields.count == _validatedFields.count);
}

@end

/*--------------------------------------------------*/
