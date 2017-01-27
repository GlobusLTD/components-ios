/*--------------------------------------------------*/

#import "GLBDataViewCalendarDaysContainer.h"
#import "GLBDataViewCalendarItem+Private.h"
#import "GLBDataViewItemsContainer+Private.h"

/*--------------------------------------------------*/
#if defined(GLB_TARGET_IOS)
/*--------------------------------------------------*/

@interface GLBDataViewCalendarDaysContainer () {
@protected
    NSCalendar* _calendar;
    GLBDataViewContainerOrientation _orientation;
    UIEdgeInsets _margin;
    UIOffset _spacing;
    CGSize _defaultSize;
}

@property(nonatomic, nonnull, strong) NSCalendar* calendar;

@end

/*--------------------------------------------------*/
#endif
/*--------------------------------------------------*/
