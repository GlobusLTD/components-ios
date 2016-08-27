/*--------------------------------------------------*/

#import "NSAttributedString+GLBNS.h"

/*--------------------------------------------------*/

@implementation NSAttributedString (GLBNS)

@end

/*--------------------------------------------------*/

@implementation NSMutableAttributedString (GLBNS)

- (NSRange)glb_appendString:(NSString*)string attributes:(NSDictionary*)attributes {
    NSUInteger location = self.length;
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:attributes]];
    return NSMakeRange(location, string.length);
}

@end

/*--------------------------------------------------*/
