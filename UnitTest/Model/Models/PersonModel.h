/*--------------------------------------------------*/

#import "BaseModel.h"

/*--------------------------------------------------*/
#pragma mark - Constants
/*--------------------------------------------------*/



/*--------------------------------------------------*/
#pragma mark - Enumerations
/*--------------------------------------------------*/



/*--------------------------------------------------*/
#pragma mark - Public interface
/*--------------------------------------------------*/

@interface PersonModel : BaseModel

@property(atomic, readonly, strong) NSString* firstName;
@property(atomic, readonly, strong) NSString* lastName;

@end

/*--------------------------------------------------*/
