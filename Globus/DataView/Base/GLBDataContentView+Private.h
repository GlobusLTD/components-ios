/*--------------------------------------------------*/

#import "GLBDataContentView.h"
#import "GLBDataViewItem+Private.h"
#import "GLBDataViewCell+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataContentView () {
@protected
    NSMutableDictionary< NSString*, Class >* _cells;
    NSMutableArray< GLBDataContentLayerView* >* _layers;
}

- (void)_receiveMemoryWarning;

@end

/*--------------------------------------------------*/

@interface GLBDataContentLayerView () {
@protected
    NSMutableDictionary< NSString*, NSMutableArray< GLBDataViewCell* >* >* _cache;
}

- (void)_receiveMemoryWarning;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
