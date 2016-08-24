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

@property(nonatomic, readonly, strong) NSString* firstName;
@property(nonatomic, readonly, strong) NSString* lastName;

@end

/*--------------------------------------------------*/