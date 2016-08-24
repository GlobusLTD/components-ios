/*--------------------------------------------------*/

#import "GLBImageView.h"
#import "GLBImageManager.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBImageView () < GLBImageManagerTarget >

@property(nonatomic, strong) NSString* processingKey;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
